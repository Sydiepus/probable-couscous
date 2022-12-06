with open("input", "r") as f:
    cal_list = list()
    cur_cal = 0
    for i in f.readlines():
        if i != "\n":
            cur_cal += int(i)
        else:
            cal_list.append(cur_cal)
            cur_cal = 0
print(f"Part 1 : {sorted(cal_list)[-1]}" , f"Part 2 : {sum(sorted(cal_list)[-3:])}", sep="\n")