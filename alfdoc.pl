# alfdoc, the shared style (github.com/Atcold/alfdoc): through ~/Library/texmf when it is installed
# there (alfdoc's own install.sh), otherwise cloned into the build folder on the first build. Then its revision line, from git.
# A .latexmkrc runs it with  do '../alfdoc.pl';  after setting $out_dir.
use Cwd ();
my $alfdoc = `kpsewhich alfdoc.sty` =~ s{/alfdoc\.sty\s*$}{}r;
if ($alfdoc eq '') {
  $alfdoc = "$out_dir/alfdoc";
  system('git', 'clone', '-q', '--depth=1', 'https://github.com/Atcold/alfdoc', $alfdoc) unless -d $alfdoc;
  ensure_path('TEXINPUTS', "$alfdoc//");
}
# do needs an absolute path: a relative one is no longer taken from '.' since Perl 5.26, and a failed do is silent.
do(Cwd::abs_path($alfdoc) . '/revision.pl');
1;
