my $filename = prompt "Path to input: ";

my $position = 50;
my $countZeroes = 0;
my $countPassesZero = 0;
for $filename.IO.lines -> $line {
    unless !$line {
        if $position == 0 {
            $countZeroes += 1;
        }
        my $turn = $line.substr(1, *).Int;
        given $line.substr(0, 1) {
            when "L" {
                if $turn >= $position {
                    $countPassesZero += ((100 - $position) + $turn) div 100;
                    if $position == 0 {
                        $countPassesZero -= 1;
                    }
                }
                $position = ($position - $turn) % 100;
            }
            when "R" {
                $countPassesZero += ($position + $turn) div 100;
                $position = ($position + $turn) % 100;
            }
        }
    }
}
say "Part 1: $countZeroes";
say "Part 2: $countPassesZero";
