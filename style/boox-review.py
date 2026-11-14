"""Copy a freshly built PDF into the e-reader's review folder, for revision.pl.

  boox-review.py <built.pdf> <name> <boox folder>

The copy goes to <boox>/Review/<name>.pdf. A Review copy that holds annotations or Skim notes
keeps them: the new build waits until they are read and cleared. A build identical in text to the
Review copy is left out, so the reader keeps its place, and so is a build whose revision line
matches the copy in <boox>/Finished/.
"""
import pathlib, shutil, subprocess, sys

import pymupdf

pdf, name, boox = pathlib.Path(sys.argv[1]), sys.argv[2], pathlib.Path(sys.argv[3])
review, finished = boox / 'Review' / f'{name}.pdf', boox / 'Finished' / f'{name}.pdf'


def say(msg):
    print(f'boox-review: {name}: {msg}', file=sys.stderr)


def text(path):
    with pymupdf.open(path) as doc:
        return [page.get_text() for page in doc]


def revision(pages):
    return next((line for line in pages[0].splitlines() if line.startswith('Revision')), None)


def notes(path):
    with pymupdf.open(path) as doc:
        count = sum(1 for page in doc for _ in page.annots())
    skim = subprocess.run(['xattr', str(path)], capture_output=True, text=True).stdout
    return count + ('skim-app_notes' in skim)


built = text(pdf)
line = revision(built)
if finished.exists() and line and 'draft' not in line and revision(text(finished)) == line:
    sys.exit(say('finished at this revision'))
if review.exists():
    if n := notes(review):
        sys.exit(say(f'held, the Review copy has {n} note(s) waiting to be read'))
    if text(review) == built:
        sys.exit(say('unchanged'))
review.parent.mkdir(parents=True, exist_ok=True)
shutil.copyfile(pdf, review)
say(f'copied to Review ({line or "no revision line"})')
