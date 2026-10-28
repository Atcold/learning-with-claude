# Learning with Claude

Lessons Claude writes for me after we work through something together: what we did, in the order we did it, with every command, its exact output, and what it means. The goal is that next time I can do it myself.

Each folder is one lesson.

- [HP Color LaserJet CP1215 on macOS](HP-CP1215/): CUPS, foomatic, Ghostscript.
- [Can cims run a program?](cims-CGI/): static files, POST, CGI.
- [Networking](networking/): the tailnet, direct paths and relays, private addresses; a smart plug on the LAN. *A stub, not yet a lesson.*
- [Where should an app keep its files?](XDG-base-dirs/): dot folders, the XDG base directories, a home for eink's data.
- [How I work with Claude](working-with-claude/): one home per project, where Claude keeps rules and memory, PARA in Dropbox, a one-column terminfo bug.

## Building

Lessons are LaTeX. In a lesson folder, run `latexmk`; the PDF lands in `build/`, named after the folder (`build/networking.pdf`). Shared colours, boxes and rules live in [`style/`](style/).
