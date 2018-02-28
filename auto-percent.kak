# arg1: enhanced keys
# arg2: default key
# arg3: no-hooks (because no prompt involved)
define-command -hidden if-cursor -params 2..3 %{
  %sh{
    length=${#kak_selections}
    if [ $length -eq 1 ]; then
      if [ -z $3 ]; then
        # on cancelled prompt
        echo "hook -group if-cursor window RawKey <esc> %{ \
          select '$kak_selection_desc'; \
          rmhooks window if-cursor
        }"
        # on absence of match
        echo "hook -group if-cursor window RuntimeError 'nothing selected|no selections remaining' %{ \
          select '$kak_selection_desc'; \
          rmhooks window if-cursor
        }"
        # on validated prompt
        echo "hook -group if-cursor window RawKey <ret> %{ \
          rmhooks window if-cursor
        }"
      fi
      # prepend percent
      echo "exec '%$kak_count$1'";
    else
      # default behavior
      echo "exec $kak_count$2"
    fi
  }
}

# to add the mappings back if needed
define-command -hidden auto-percent-map %{
  map global normal s ':if-cursor s s<ret>' -docstring 'auto-percent s'
  map global normal S ':if-cursor S S<ret>' -docstring 'auto-percent S'
  map global normal <a-s> ':if-cursor <lt>a-s> <lt>a-s> no-hooks<ret>' -docstring 'auto-percent <a-s>'
  map global normal <a-S> ':if-cursor <lt>a-S> <lt>a-S> no-hooks<ret>' -docstring 'auto-percent <a-S>'
  map global normal <a-k> ':if-cursor <lt>a-s><lt>a-k> <lt>a-k><ret>' -docstring 'auto-percent <a-k>'
  map global normal <a-K> ':if-cursor <lt>a-s><lt>a-K> <lt>a-K><ret>' -docstring 'auto-percent <a-K>'
}

# in rare scenarios when you need the original mappings
define-command -hidden auto-percent-unmap %{
  unmap global normal s
  unmap global normal S
  unmap global normal <a-s>
  unmap global normal <a-S>
  unmap global normal <a-k>
  unmap global normal <a-K>
}

# init
auto-percent-map
