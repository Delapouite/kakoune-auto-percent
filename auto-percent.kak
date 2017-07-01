# used to cancel with <esc> and restore previous cursor
decl -hidden str previous_cursor ''

def -hidden if-cursor -params 2 %{
  set window previous_cursor %val{selection_desc}
  %sh{
    length=${#kak_selections}

    if [ $length -eq 1 ]; then
      # on cancelled prompt
      echo "hook -group if-cursor window RawKey <esc> %{ \
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

map global normal s ':if-cursor s s<ret>'
map global normal S ':if-cursor S S<ret>'
map global normal <a-s> ':if-cursor <lt>a-s> <lt>a-s><ret>'
map global normal <a-k> ':if-cursor <lt>a-s><lt>a-k> <lt>a-k><ret>'
map global normal <a-K> ':if-cursor <lt>a-s><lt>a-K> <lt>a-K><ret>'
