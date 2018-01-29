# kakoune-auto-percent

[kakoune](http://kakoune.org) plugin to enhance some primitives with bigger selections.

## Install

Add `auto-percent.kak` to your autoload dir: `~/.config/kak/autoload/`.

## Usage

Some primitives commands only make sense when they operate on selections bigger than the simple *cursor selection*.

For instance, pressing `s` in normal mode with just a single *cursor selection* is not really useful.
With this script, pressing `s` will first select the whole content of the buffer with `%`. Hence the name of this plugin.

When the main selection is bigger than 1 char or/and they are more than 1 selection, the default behavior is applied.

Here are the commands affected by this script:

- select: `s` → `%s`
- split: `S` → `%S`
- split on new lines: `<a-s>` → `%<a-s>`
- keep matching: `<a-k>` → `%<a-s><a-k>`
- keep not matching: `<a-K>` → `%<a-s><a-K>`

## See Also

This behavior is somehow similar to the one found in [vis](https://github.com/martanne/vis):

    If only one selection exists x and y default to the whole file 0,$.
    
In Kakoune dialect: the `x` command is `s` (select), the `y` command is `S` (split) and  the `0,$` address is `%` (whole buffer).

## Licence

MIT

Thanks a lot to [danr](https://github.com/danr) and [occivink](https://github.com/occivink)
for their input: https://www.reddit.com/r/kakoune/comments/6i591e/percent_by_default_on_some_noop_commands/
