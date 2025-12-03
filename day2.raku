sub isInvalidRepeated($snum) {
    for 1..$snum.chars div 2 -> $i {
        my $allEqual = True;
        my $start = $snum.substr(0, $i);
        my $cut = $snum.chars % $i;        
        for 1..($snum.chars div $i + (1 if $cut > 0) - 1) -> $part {
            my $parts = $snum.substr($part * $start.chars, $start.chars);
            if $parts ne $start {
                $allEqual = False;
            }
        }
        if $allEqual {
            return True;
        }
    }
    return False;
}

sub MAIN($filename) {
    my $invalidSum = 0;
    my $invalidSumRepeated = 0;
    for $filename.IO.lines -> $line {
        unless !$line {
            for $line.split(',') -> $pair {
                my @arr = $pair.split('-');
                for @arr[0].Int..@arr[1].Int -> $num {
                    my $snum = ~$num;
                    my $sl = $snum.chars div 2;
                    my $l = $snum.substr(0, $sl + $snum.chars % 2);
                    my $r = $snum.substr($sl + $snum.chars % 2, *);
                    if $l eq $r { 
                        $invalidSum += $num;
                    }
                    if isInvalidRepeated($snum) {
                        $invalidSumRepeated += $num;                        
                    }                    
                }
            }
        }
    }
    say "Part 1: $invalidSum";
    say "Part 2: $invalidSumRepeated";
}
