$pdf_mode = 4;                                   # lualatex
$out_dir = 'build';
@default_files = ('debug-log.tex');
ensure_path('TEXINPUTS', '../style//');         # the shared lesson.sty
