$pdf_mode = 4;                                   # lualatex
$out_dir = 'build';
@default_files = ('lesson.tex');
$jobname = 'XDG-base-dirs';                     # PDF named after the lesson
do '../alfdoc.pl';                               # the shared style and the revision line
