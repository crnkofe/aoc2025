sub at($s, $i) {
    my $l = $s.chars;
    if $i < 0 || $i >= $s.chars {
        return '';
    }
    return $s.comb[$i];
}

sub slic($s, $i, $ct) {
    if $s eq "" {
        return 0;
    }    
    my $l = 3;
    if $i < 0 {
        $l += $i;
    }
    my $ss = $s.substr(max(0, $i), $l); 
    return $ss.trans('.' => '', :delete).chars;
}

sub countAccessibleIn2($line1, $line2, $line3) {
    my $count = 0;
    
    for 0..$line2.chars -> $i {
        if at($line2, $i) eq "@" {
            my $countPoint = slic($line1, $i-1, 2);
            $countPoint += slic($line2, $i-1, 2) - 1;
            $countPoint += slic($line3, $i-1, 2);
            if $countPoint < 4 {
                $count += 1;
            }
        }
    }

    return $count;
}

sub replaceAccessibleIn2($line1, $line2, $line3) {
    my $c = "";
    for 0..$line2.chars -> $i {
        if at($line2, $i) eq "@" {
            my $countPoint = slic($line1, $i-1, 2);
            $countPoint += slic($line2, $i-1, 2) - 1;
            $countPoint += slic($line3, $i-1, 2);
            if $countPoint < 4 {
                $c = $c ~ ".";
            } else {
                $c = $c ~ "@";
            }
        } else {
            $c = $c ~ ".";
        }
    }
    return $c;
}

sub clean(@lineList) {
    my $countAccessible = 0;
    my $line1 = "";
    my $line2 = "";

    my @linesCopy = ();
    for @lineList -> $line {
        if $line2 ne "" {
            $countAccessible += countAccessibleIn2($line1, $line2, $line);
            my $res = replaceAccessibleIn2($line1, $line2, $line);
            @linesCopy.push($res);
        }

        $line1 = $line2;
        $line2 = $line;
    }
    $countAccessible += countAccessibleIn2($line1, $line2, "");
    @linesCopy.push(replaceAccessibleIn2($line1, $line2, ""));
    return ($countAccessible, @linesCopy);
}

sub MAIN($filename) {
    my @linesCopy = ();
    for $filename.IO.lines -> $line {
        unless !$line {
            @linesCopy.push($line);
        }
    }
    my ($ct, $newLines) = clean(@linesCopy);
    say "Part 1: $ct";

    my $countRemoved = $ct;
    while $ct > 0 {
        ($ct, $newLines) = clean($newLines);
        $countRemoved += $ct;
    }
    say "Part 2: $countRemoved";
}
