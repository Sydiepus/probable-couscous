# Github copilot Solution.

# open file "input" and readlines.
# for each line, split the line at "," and check if the range is fully contains the second range.
# if it is, then add 1 to the counter.
# print the counter.
def solve():
    counter = 0
    with open("input", 'r') as f:
        for line in f.readlines():
            line = line.strip()
            if line == "":
                continue
            line = line.split(",")
            if overlap(line[0], line[1]):
                counter += 1
    print("Part 1 : " + str(counter))

# given 2 strings, each string is a range of numbers separated by "-".check if the first range is fully contains the second range and vice versa.
# if it is, return True. else, return False.
# for example, given "1-3" and "2-3", return True.
# given "1-3" and "4-5", return False.
# given "1-3" and "1-3", return True.
# given "1-3" and "1-4", return True.
# given "1-3" and "0-4", return False.
# given "1-3" and "0-2", return False.
def overlap(a, b):
    a = a.split("-")
    b = b.split("-")
    a1 = int(a[0])
    a2 = int(a[1])
    b1 = int(b[0])
    b2 = int(b[1])
    if a1 <= b1 and a2 >= b2:
        return True
    if b1 <= a1 and b2 >= a2:
        return True
    return False

solve()

#part 2
# Path: day4/t.py
# open file "input" and readlines.
# for each line, split the line at "," and check if the range overlap the second range and vice versa.
# for example, given "1-3" and "2-3", return True.
# given "1-3" and "4-5", return False.
# given "1-3" and "1-3", return True.
# given "1-3" and "1-1", return True.
# given "1-3" and "0-4", return True.
# given "1-3" and "0-2", return True.
# given "1-3" and "0-1", return True.
# given "1-3" and "2-4", return True.
# given "1-3" and "3-4", return True.

# if it is, then add 1 to the counter.
# print Part 2 : + the counter.
def solve_2():
    counter = 0
    with open("input", 'r') as f:
        for line in f.readlines():
            line = line.strip()
            if line == "":
                continue
            line = line.split(",")
            if contain(line[0], line[1]):
                counter += 1
    print("Part 2 : " + str(counter))

def contain(a, b):
    a = a.split("-")
    b = b.split("-")
    a1 = int(a[0])
    a2 = int(a[1])
    b1 = int(b[0])
    b2 = int(b[1])
    if a1 <= b1 and a2 >= b2:
        return True
    if b1 <= a1 and b2 >= a2:
        return True
    if a1 <= b1 and a2 >= b1 and a2 <= b2:
        return True
    if b1 <= a1 and b2 >= a1 and b2 <= a2:
        return True
    return False

solve_2()