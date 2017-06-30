# provide enhance behavior first, then default behavior
def -hidden if-cursor -params 2 %{ %sh{
  length=${#kak_selections}
  [ $length -eq 1 ] && echo "exec $1" || echo "exec $2"
}}

map global normal s ':if-cursor \\%s s<ret>'
map global normal S ':if-cursor \\%S S<ret>'
map global normal <a-s> ':if-cursor \\%<lt>a-s> <lt>a-s><ret>'
map global normal <a-k> ':if-cursor \\%<lt>a-s><lt>a-k> <lt>a-k><ret>'
map global normal <a-K> ':if-cursor \\%<lt>a-s><lt>a-K> <lt>a-K><ret>'

