# arg1: enhanced key
# arg2: default key
define-command -hidden if-cursor -params 2 %{
  %sh{
    length=${#kak_selections}

    if [ $length -eq 1 ]; then
      # on cancelled prompt
      echo "hook -group if-cursor window RawKey <esc> %{ \
        select '$kak_selection_desc'; \
        rmhooks window if-cursor
      }"
      # on absence of match
      echo "hook -group if-cursor window RuntimeError 'nothing selected|no selections remaining' %{ \
        select '$kak_opt_previous_cursor'; \
        rmhooks window if-cursor
      }"
      # on validated prompt
      echo "hook -group if-cursor window RawKey <ret> %{ \
        rmhooks window if-cursor
      }"
      # prepend percent
      echo "exec '%$kak_count$1'";
    else
      # default behavior
      echo "exec $kak_count$2"
    fi
  }
}

map global normal s ':if-cursor s s<ret>' -docstring 'autopercent s'
map global normal S ':if-cursor S S<ret>' -docstring 'autopercent S'
map global normal <a-s> ':if-cursor <lt>a-s> <lt>a-s><ret>' -docstring 'autopercent <a-s>'
map global normal <a-S> ':if-cursor <lt>a-S> <lt>a-S><ret>' -docstring 'autopercent <a-S>'
map global normal <a-k> ':if-cursor <lt>a-s><lt>a-k> <lt>a-k><ret>' -docstring 'autopercent <a-k>'
map global normal <a-K> ':if-cursor <lt>a-s><lt>a-K> <lt>a-K><ret>' -docstring 'autopercent <a-K>'
