# kakoune-auto-percent

[kakoune](http://kakoune.org) plugin to enhance some primitives with bigger selections.

## Install

Add `auto-percent.kak` to your autoload dir: `~/.config/kak/autoload/`.

## Usage

Some normal commands only make sense when they operate on selections bigger than the simple *cursor selection*.

For instance, pressing `s` in normal mode with just a single *cursor selection* is not really useful.
With this script, pressing `s` will first select the whole content of the buffer with `%`. Hence the name of this plugin.

When the main selection is bigger than 1 char or/and they are more than 1 selection, the default behavior is applied.

Here are the normal commands affected by this script:

- select: `s` → `%s`
- split: `S` → `%S`
- split on new lines: `<a-s>` → `%<a-s>`
- split on boundaries: `<a-S>` → `%<a-S>`
- keep matching: `<a-k>` → `%<a-s><a-k>`
- keep not matching: `<a-K>` → `%<a-s><a-K>`
- rotate selections forward: `)` → `%<a-s>)`
- rotate selections backward: `(` → `%<a-s>(`
- rotate selections contents forward: `<a-)>` → `%<a-s><a-)>`
- rotate selections contents backward: `<a-(>` → `%<a-s><a-(>`

If the commands above display a prompt and you cancel it (with `<esc>`), you'll get back the original cursor.
Same thing for matching errors.

To remove the mappings if needed, run `auto-percent-unmap` (`auto-percent-map` to add them back).

Another good candidate to tweak: merge continuous selections `<a-m>`

### `select-complement` command

The `select-complement` command is useful in *oops* scenarios. Let's illustrate with a quick example.

You want to `split` the elements of the following list `(foo, bar, qux)` in order to rotate them (with `<a-)>`) later on.
So you do `<a-i>b` to select inside the parens and then do `s, <ret>`. Oops, you've made a mistake by selecting the commas and
spaces which was not what you had in mind. The correct operation would have been to use `S` (split) instead of `s`.

Unfortunately, Kakoune does not currently provide on easy way to *undo a selection*.

You can fix your problem with `select-complement`. What it does is going back in time and doing the `<a-i>b` again (using auto marks),
and running the `S` command with the same regex you've just provided.

So to recap, with this command you can toggle between:
- `s` <-> `S`
- `<a-k>` <-> `<a-K>`

Note that it's only intented to work when you execute it *immediately* after.

## See Also

This behavior is somehow similar to the one found in [vis](https://github.com/martanne/vis):

    If only one selection exists x and y default to the whole file 0,$.

In Kakoune dialect: the `x` command is `s` (select), the `y` command is `S` (split) and  the `0,$` address is `%` (whole buffer).

- [kakoune-auto-star](https://github.com/Delapouite/kakoune-auto-star)

## Licence

MIT

Thanks a lot to [danr](https://github.com/danr) and [occivink](https://github.com/occivink)
for their input: https://www.reddit.com/r/kakoune/comments/6i591e/percent_by_default_on_some_noop_commands/
