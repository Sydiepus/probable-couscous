file = open("input.txt", "r")
lines = [i.strip().split() for i in file.readlines()]
data = [(k[0], int(k[1])) for k in lines]

def pos(instructions, aim=1) :
    hoz_pos = 0
    depth = 0
    aim = aim
    if aim == 1 :
       for i in instructions :
            if i[0] == "forward" :
                hoz_pos += i[1]
            elif i[0] == "down" :
                depth += i[1]
            elif i[0] == "up" :
                depth -= i[1]
    elif aim == 0 :
        for i in instructions :
            if i[0] == "forward" :
                hoz_pos += i[1]
                depth += aim * i[1]
            elif i[0] == "down" :
                aim += i[1]
            elif i[0] == "up" :
                aim -= i[1]
    return str(depth * hoz_pos)

#part 1.
print("position part 1 : " + pos(data))

#part 2.
print("position part 2 : " + pos(data, aim=0))