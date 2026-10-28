$pdf_mode = 4;                                   # lualatex
$out_dir = 'build';
@default_files = ('lesson.tex');
$jobname = 'working-with-claude';                     # PDF named after the lesson
ensure_path('TEXINPUTS', '../style//');         # the shared lesson.sty
