# Lesson style

`lesson.sty` holds what every lesson shares: the [Set3](https://colorbrewer2.org/#type=qualitative&scheme=Set3&n=12) and tone colours, `\name`, the `shell`, `out` and `python` listings, and the `insight`, `pane` and `cmdout` boxes. A lesson loads it with `\usepackage{lesson}`; its `.latexmkrc` adds `ensure_path('TEXINPUTS', '../style//');`. Boxes only one lesson uses stay in that lesson.

Rules the package cannot enforce:

- Every name of a thing (program, file, folder, host) in sans, with `\name{}`. Monospace only for literal text you would type or see printed. A name that is a link is underlined in grey, with `\lk{}` inside `\name{}`; nothing else is underlined.
- TikZ defaults: plain `->` tips, default line width, labels clear of the arrows.
- Pinyin and characters are always tone-coloured.
- Each feedback round marks every edit with `\here[what changed]`: a numbered hand in the margin with a tiny italic note. `\reviewfalse` hides them all.
- From now on, a feedback round marks each kind of edit once, in the left margin: a green `\added`, an `\edited` ±, a red `\removed{text}` that shows the text struck out, each with an optional tiny note, *e.g.* `\edited[underline]`.
