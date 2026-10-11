# HP Color LaserJet CP1215 on macOS

HP never made a macOS driver for this printer. The one we use is Rick Richardson's open-source [foo2zjs](https://web.archive.org/web/20210129024712/https://foo2zjs.rkkda.com/) (his site is offline; that is a Wayback Machine snapshot), now maintained by [OpenPrinting](https://github.com/OpenPrinting/foo2zjs).

Printing from the print dialog (⌘P) used to work, then stopped. Running the driver's wrapper from the terminal still worked, but Mamma can't use a terminal, so I wrote `print.py`, a small window around it. On her current Mac, AlfMAC3, neither printed.

This lesson is how we got both working again. Two bugs: a Ghostscript missing its support files broke both routes, and `foomatic-rip` converting PDFs with Ghostscript's `pswrite` device, removed in 2013 broke ⌘P.

- `debug-log.tex`: the lesson.
- `print.py`: my print script, as listed in the lesson.
- `print-ui.png`: its window.
