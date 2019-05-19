declare-option -hidden str last_auto_percent

# arg1: enhanced keys
# arg2: default key
# arg3: no-hooks (because no prompt involved)
define-command -hidden if-cursor -params 2..3 %{
  # save selection before operation for later 'select-complement'
  execute-keys '"zZ'
  set-option window last_auto_percent %arg{2}

  evaluate-commands %sh{
    length=${#kak_selections}
    # 3 = 1 char + 2 quotes
    if [ $length -eq 3 ]; then
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
      echo "execute-keys '%$kak_count$1'";
    else
      # default behavior
      echo "execute-keys $kak_count$2"
    fi
  }
}

define-command select-complement -docstring 'select complement from previous s/S <a-k>/<a-K> operation' %{
  # restore previous selection from z register
  execute-keys '"zz'
  evaluate-commands %sh{
    case "$kak_opt_last_auto_percent" in
      's') k='S' ;;
      'S') k='s' ;;
      '<a-k>') k='<a-K>' ;;
      '<a-K>') k='<a-k>' ;;
    esac
    if [ -n "$k" ]; then
      # to call select-complement again
      echo "set-option window last_auto_percent $k"
      echo "execute-keys $k <ret>"
    fi
  }
}

# to add the mappings back if needed
define-command -hidden auto-percent-map %{
  map global normal s ': if-cursor s s<ret>' -docstring 'auto-percent s'
  map global normal S ': if-cursor S S<ret>' -docstring 'auto-percent S'
  map global normal <a-s> ': if-cursor <lt>a-s> <lt>a-s> no-hooks<ret>' -docstring 'auto-percent <a-s>'
  map global normal <a-S> ': if-cursor <lt>a-S> <lt>a-S> no-hooks<ret>' -docstring 'auto-percent <a-S>'
  map global normal <a-k> ': if-cursor <lt>a-s><lt>a-k> <lt>a-k><ret>' -docstring 'auto-percent <a-k>'
  map global normal <a-K> ': if-cursor <lt>a-s><lt>a-K> <lt>a-K><ret>' -docstring 'auto-percent <a-K>'
  map global normal ( ': if-cursor <lt>a-s>( ( no-hooks<ret>' -docstring 'auto-percent ('
  map global normal ) ': if-cursor <lt>a-s>) ) no-hooks<ret>' -docstring 'auto-percent )'
  map global normal <a-(> ': if-cursor <lt>a-s><lt>a-(> <lt>a-(> no-hooks<ret>' -docstring 'auto-percent <a-(>'
  map global normal <a-)> ': if-cursor <lt>a-s><lt>a-)> <lt>a-)> no-hooks<ret>' -docstring 'auto-percent <a-)>'
}

# in rare scenarios when you need the original mappings
define-command -hidden auto-percent-unmap %{
  unmap global normal s
  unmap global normal S
  unmap global normal <a-s>
  unmap global normal <a-S>
  unmap global normal <a-k>
  unmap global normal <a-K>
  unmap global normal (
  unmap global normal )
  unmap global normal <a-(>
  unmap global normal <a-)>
}

# init
auto-percent-map
