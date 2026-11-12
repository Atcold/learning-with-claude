# Brief for a new setup

This brief is for Claude, working with someone whose files and habits make things hard to find. The starting point can be any of the usual ones: everything saved in Downloads, a Desktop covered in files, one huge folder with no structure, the same project spread across Dropbox, Google Drive, and email, notes in several apps or none, or every Claude session started from the home folder so all projects share one memory. The lesson next to it, `lesson.tex`, describes the setup I ended up with: one home per project, rules in one place, and a notes vault for what spans projects. That lesson is the shape to aim for. This brief is the way to get there, one step at a time, with the owner deciding at every step.

## 1. Look before touching anything

Find where the person actually keeps things: the folders they save into (often Downloads, Desktop, and Documents), the cloud services they use, and where their notes and repositories live. Survey those places without changing them. Group the files by kind (papers, slides, code, datasets, installers, images, archives), by age, and by size, and find exact duplicates by their checksum. Show the owner a short summary: how many files of each kind and where, the largest ones, the duplicates, and the installers (`.dmg`, `.pkg`) that have already done their job.

## 2. Ask what the work is

Ask the owner what they are working on now (courses, research projects, applications), what they look after over time (teaching, health, finances), and what they keep only as reference. These answers become the folders, so the layout follows their work and the files are sorted into it.

## 3. Propose a layout and wait for an answer

Propose a small layout following PARA (Projects, Areas, Resources, and Archive, from Tiago Forte's *Building a Second Brain*): `~/PARA/Projects/<name>/` for work with an end, `~/PARA/Areas/` for what continues, `~/PARA/Resources/` for reference, and `~/PARA/Archive/` for what is finished. Git repositories go in one folder outside any cloud-synced folder, such as `~/Work/GitHub/`, and temporary files go in `~/Work/Scratch/`. Show the layout as a short nested list and create it only after the owner agrees.

## 4. Move files in small batches

Move one group at a time, for example all the papers, after showing the owner which file goes where. Write every move to a log, `~/PARA/moves.tsv`, with the old path and the new one, so any batch can be undone. Put duplicates and spent installers in `~/PARA/To delete/`, where the owner empties them after a look. The folder the owner habitually saves into, usually Downloads, becomes an inbox: anything new lands there and gets sorted the same way.

## 5. Give each project its own home

Start each Claude session from the project's folder, so Claude's memory for that project stays with it, and keep a short `note.md` there with the goal, the next action, and a dated log. Write the owner's global rules in `~/.claude/CLAUDE.md` last, once a few weeks of work show how they actually like to work.
