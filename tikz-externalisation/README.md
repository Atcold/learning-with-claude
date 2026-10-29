# One figure file, several cached pictures

A TikZ figure drawn several times with flags, cached by externalisation: why one fixed name makes every variant the same picture, how my book names each variant (an `\if…\else` chain, or a default plus overrides), why an `\edef`-built name also works but hides the file names, and why the book's `build.sh` can only build literal names.

- `lesson.tex`: the lesson.
- `demo/`: the miniature, one dot drawn plain and red; compile `fixed.tex`, `off.tex`, `chain.tex`, `override.tex`, `edef.tex` or `inline.tex` with `pdflatex -shell-escape`.
