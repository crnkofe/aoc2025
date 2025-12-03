sub maxConsecutiveNum($s) {
    if $s == "" {
        return 0;
    }
    if $s.chars == 1 {
        return $s.Int;
    }

    my @chs = $s.comb;
    my $c1 = @chs[0].Int;
    my $c2 = 0;
    for @chs[1..*] -> $c {
        if $c.Int > $c2 {
            $c2 = $c.Int;
        }
    }
    return $c1 * 10 + $c2;
}

sub removeFirstNum($s) {
    # find first number lower than the next one and remove it
    my @chs = $s.comb;
    my $at = 0;
    while $at < ($s.chars-1) && @chs[$at].Int >= @chs[$at+1].Int {
        $at +=1;
    }
    my $l = $s.substr(0, $at);
    my $r = $s.substr($at+1, *);
    return $l ~ $r;
}

sub MAIN($filename) {
    my $joltageSum = 0;
    my $maxJoltageSum = 0;
    for $filename.IO.lines -> $line {
        unless !$line {
            my $num = maxConsecutiveNum($line);
            for 1..$line.chars -> $sl {
                my $nextNum = maxConsecutiveNum($line.substr($sl, *));
                if $nextNum > $num {
                    $num = $nextNum;
                }
            }
    
            my $shortenedLine = $line;
            while $shortenedLine.chars > 12 {
                $shortenedLine = removeFirstNum($shortenedLine);
            }
            $joltageSum += $num;
            $maxJoltageSum += $shortenedLine.Int;
        }
    }
    say "Part 1: $joltageSum";
    say "Part 2: $maxJoltageSum";
}
