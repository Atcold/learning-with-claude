# alfdoc, the shared style (github.com/Atcold/alfdoc): through ~/Library/texmf when it is linked
# there, otherwise cloned into the build folder on the first build. Then its revision line, from git.
# A .latexmkrc runs it with  do '../alfdoc.pl';  after setting $out_dir.
my $alfdoc = `kpsewhich alfdoc.sty` =~ s{/alfdoc\.sty\s*$}{}r;
if ($alfdoc eq '') {
  $alfdoc = "$out_dir/alfdoc";
  system('git', 'clone', '-q', '--depth=1', 'https://github.com/Atcold/alfdoc', $alfdoc) unless -d $alfdoc;
  ensure_path('TEXINPUTS', "$alfdoc//");
}
do "$alfdoc/revision.pl";
1;
