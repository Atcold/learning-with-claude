# One figure file, several cached pictures

A TikZ figure drawn several times with flags, cached by externalisation: why one fixed name makes every variant the same picture, how my book names each variant (an `\if…\else` chain, or a default plus overrides), and why an `\edef`-built name also works but hides the file names.

- `lesson.tex`: the lesson.
- `demo/`: the miniature, where `circle.tex` draws a filled circle, plain or red; run an experiment with `pdflatex -shell-escape fixed` (or `off`, `chain`, `override`, `edef`, `inline`).
