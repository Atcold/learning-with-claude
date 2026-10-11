#!/bin/bash
# Open questions from the lesson, checked on AlfMAC3. Read-only: works in a temp folder.
# Run from AlfMAC5:  ssh alfmac3 'bash -s' < probe-alfmac3.sh
#
#   1. Does Ghostscript read a PDF from a stream as well as from a file?
#   2. Does the wrapper?  (print.py gives it a file; foomatic-rip would give it a stream)
#   3. Why does pdftops fail inside CUPS?  (here: does it work at all, as you)
#   4. Does foomatic-rip 4.0.6 know a separate command line for PDF input?
#   5. The state of the lesson's other open items (job 132, the original PPD, job 156, debug logging)

cd "$(mktemp -d)" || exit 1
echo "working in $PWD"

# Show a result: size in bytes and the first readable characters
show() { printf '%-28s %8s bytes  %s\n' "$1" "$(wc -c < "$1" | tr -d ' ')" "$(head -c 16 "$1" | strings | head -1)"; }

# The same one-page test PDF as in the lesson, plus a PostScript copy of it
gs -q -sDEVICE=pdfwrite -sPAPERSIZE=a4 -o t.pdf \
  -c "/Helvetica findfont 40 scalefont setfont 100 400 moveto (Test) show showpage"
gs -q -sDEVICE=ps2write -o t.ps t.pdf
show t.pdf; show t.ps

echo; echo "== 1. Ghostscript: PDF as a file, then as a stream (-)"
gs -q -sDEVICE=pbmraw -r100 -o gs-file.pbm   t.pdf
gs -q -sDEVICE=pbmraw -r100 -o gs-stream.pbm - < t.pdf
show gs-file.pbm; show gs-stream.pbm
cmp -s gs-file.pbm gs-stream.pbm && echo "same bitmap" || echo "DIFFERENT"

echo; echo "== 2. The wrapper: PDF file, PDF stream, PostScript stream"
W=$(command -v foo2hp2600-wrapper)
echo "wrapper: $W"
"$W" -p9 -z1 -c -d1 t.pdf   > w-pdf-file.prn   2> w-pdf-file.err;   echo "exit=$?"
"$W" -p9 -z1 -c -d1 < t.pdf > w-pdf-stream.prn 2> w-pdf-stream.err; echo "exit=$?"
"$W" -p9 -z1 -c -d1 < t.ps  > w-ps-stream.prn  2> w-ps-stream.err;  echo "exit=$?"
show w-pdf-file.prn; show w-pdf-stream.prn; show w-ps-stream.prn
tail -n 3 w-*.err
echo "-- how the wrapper handles PDF:"
grep -n -i -E 'pdf' "$W" | head -20

echo; echo "== 3. pdftops by hand, as you"
pdftops -level2 -origpagesizes t.pdf pdftops.ps; echo "exit=$?"
show pdftops.ps
echo "(next, in the shared pane, as CUPS's user:  sudo -u _lp pdftops -level2 -origpagesizes $PWD/t.pdf /tmp/lp.ps)"

echo; echo "== 4. foomatic-rip: a separate command line for PDF?"
strings /usr/local/bin/foomatic-rip | grep -i -E 'CommandLinePDF|understand PDF'

echo; echo "== 5. Open items"
echo "-- job 132's leftover record (may need sudo to list):"
ls -la /private/var/spool/cups/ 2>&1 | grep -E 'c00132|Permission'
echo "-- the original PPD: is the PDF route still there?"
zgrep -n cupsFilter /Library/Printers/PPDs/Contents/Resources/HP-Color_LaserJet_CP1215.ppd.gz
echo "-- jobs still waiting (156?):"
lpstat -o
echo "-- CUPS debug logging:"
cupsctl | grep -i debug
