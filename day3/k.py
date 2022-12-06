def priority(c):
    val = c
    if c <= 90:
        val -= 38
    else:
        val -= 96
    return val

with open("input", "r") as f:
    sum = 0
    i = 0
    f_set = 0
    s_set = 0
    t_set = 0
    p_sum = 0
    for line in f.readlines():
        match i:
            case 0:
                f_set = set(line.strip())
                i += 1
            case 1:
                s_set = set(line.strip())
                i += 1
            case 2:
                t_set = set(line.strip())
                i = 0
                char2 = f_set & s_set & t_set
                p_sum += priority(ord(char2.pop()))
        f_half = set(line[:len(line)//2])
        s_half = set(line[len(line)//2:])
        char = f_half & s_half
        sum += priority(ord(char.pop()))
    print(f"Part 1 : {sum}")
    print(f"Part 2 : {p_sum}")