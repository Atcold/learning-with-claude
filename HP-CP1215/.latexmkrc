$pdf_mode = 4;                                   # lualatex
$out_dir = 'build';
@default_files = ('debug-log.tex');
$jobname = 'HP-CP1215';                         # PDF named after the lesson
do '../alfdoc.pl';                               # the shared style and the revision line
