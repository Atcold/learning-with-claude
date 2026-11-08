# Local coding on AlfSPARK

The local coding fallback: a Qwen Flash-Next model served by vLLM in a container on AlfSPARK, reached from OpenCode on the Mac through an SSH tunnel over the tailnet, reading the same Claude rules and the project note rather than a second copy of instructions. The lesson records the four pieces, the commands that start them, and what is still unproven.

OpenCode 1.19.5 and its shared configuration are installed on AlfMAC5. The `oca` alias in the shared Bash settings opens the current project with `note.md` and automatically accepts permission requests; `oca --continue` resumes its latest conversation. Reload an existing Mac shell with `source ~/.bashrc` after updating the settings. The model container and SSH tunnel must already be running; the lesson contains their start and stop commands.

- `lesson.tex`: the lesson.
