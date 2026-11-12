# Revision line from git, for alfdoc's \revisionline. A lesson's .latexmkrc runs it with
#   do '../style/revision.pl';
# and any other document's with
#   do "$ENV{HOME}/Library/texmf/tex/latex/alfdoc/revision.pl";
# after setting $out_dir and $jobname (or @default_files). It writes <out_dir>/<jobname>.rev:
# the number of commits that touched the document's folder, and the date and short hash of the
# last one, then one row per commit for the revision table, each hash with its GitHub link. A folder with uncommitted changes is the next revision, a draft
# dated today on top of that commit.
my $count = `git rev-list --count HEAD -- . 2>/dev/null`;
chomp $count;
if ($count ne '') {
  my $last = `git log -1 --format='%h|%cd' --date=format:'%a %-d %b %Y' -- .`;
  chomp $last;
  my ($hash, $date) = split /\|/, $last;
  my $draft = `git status --porcelain -- .` ne '' ? 1 : 0;
  if ($draft) {
    $count += 1;
    my @t = localtime;
    my @day = qw(Sun Mon Tue Wed Thu Fri Sat);
    my @mon = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
    $date = sprintf '%s %d %s %d', $day[$t[6]], $t[3], $mon[$t[4]], $t[5] + 1900;
  }
  # GitHub page of the repo, so each hash in the table links to its diff
  my $web = `git remote get-url origin 2>/dev/null`;
  chomp $web;
  $web =~ s{^git\@github\.com:}{https://github.com/};
  $web =~ s{\.git$}{};
  $web = '' unless $web =~ m{^https://github\.com/};
  my $dir = $out_dir || '.';
  my $job = $jobname || ($default_files[0] // '') =~ s/\.tex$//r;
  mkdir $dir;
  open my $fh, '>', "$dir/$job.rev" or die "revision.pl: $!";
  print $fh "\\alfdoc\@revision{$count}{$date}{$hash}{$draft}\n";
  # Date cells: weekday, day, month and year. A value that repeats the row above is \alfdoc@same,
  # light grey: the month and year alone, the weekday and day only with the whole date.
  my ($prev_day, $prev_month) = ('', '');
  my $cells = sub {
    my ($wd, $dd, $my) = split / /, $_[0], 3;
    my $same_day = "$wd $dd $my" eq $prev_day;
    my $out = join ' & ', ($same_day ? ("\\alfdoc\@same{$wd}", "\\alfdoc\@same{$dd}") : ($wd, $dd)),
      ($my eq $prev_month ? "\\alfdoc\@same{$my}" : $my);
    ($prev_day, $prev_month) = ("$wd $dd $my", $my);
    return $out;
  };
  my @log = reverse split /\n/,
    `git log --format='%h|%cd|%s' --date=format:'%a %-d %b %Y' -- .`;
  my $n = 0;
  for (@log) {
    my ($h, $d, $s) = split /\|/, $_, 3;
    # Review: “It's useless having working-with-claude: in the subject. I already commit one
    # lesson at a time, so it's just wasting space.”
    $s =~ s/^\Q$job\E: //;  # the table is this lesson's already
    $s =~ s/([\\{}])/\\char`\\$1/g;  # backslash and braces first, as characters
    $s =~ s/([&%\$#_])/\\$1/g;
    $s =~ s/~/\\textasciitilde{}/g;
    $s =~ s/\^/\\textasciicircum{}/g;
    $n++;
    print $fh "\\alfdoc\@revrow{$n}{" . $cells->($d) . "}{$h}{$s}\n";
    print $fh "\\alfdoc\@commiturl{$h}{$web/commit/$h}\n" if $web;
  }
  print $fh "\\alfdoc\@revrow{$count}{" . $cells->($date) . "}{}{Uncommitted changes, this draft}\n" if $draft;
  close $fh;
}
1;
