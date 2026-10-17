$pdf_mode = 4;                                   # lualatex
$out_dir = 'build';
@default_files = ('lesson.tex');
ensure_path('TEXINPUTS', '../style//');         # the shared lesson.sty
