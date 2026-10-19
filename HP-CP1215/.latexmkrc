$pdf_mode = 4;                                   # lualatex
$out_dir = 'build';
@default_files = ('debug-log.tex');
$jobname = 'HP-CP1215';                         # PDF named after the lesson
ensure_path('TEXINPUTS', '../style//');         # the shared lesson.sty
