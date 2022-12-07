# part 1 : python3 l.py | awk '{if ($1 <= 100000) {sum += $1}} END {print "Part 1: " sum; print "Complete size (use for part 2) : " $1}'
# 70000000 - 42536714 = 27463286
# part 2 : python3 l.py | awk '{if ($1 + 27463286 >= 30000000) {print $1}}' | sort -n | head -n1
@load "filefuncs"
{
    if ($3 == "/") {
        d = "/home/mp/AOC/day7/aoc/"
    } else {
        d = $3
    }
    if ($2 == "cd") {
        chdir(d)
    } else if ($1 == "dir") {
        system("mkdir " $2)
    } else if ($1 > 0) {
        system("truncate -s" $1 " " $2)
    }
}