file = open("input.txt", "r")
lines = file.readlines()
lines = [int(i.strip()) for i in lines]

def get_increases(numbers_list) :
    larger = 0
    for i in range(len(numbers_list)) :
        if numbers_list[i] > numbers_list[i - 1] :
            larger += 1
    return larger

sum_list = [(lines[i] + lines[i + 1] + lines[i + 2]) for i in range(len(lines) - 2)]

increases = get_increases(lines)
sum_increases = get_increases(sum_list)
print("part 1 : " + str(increases))
print("part 2 : " + str(sum_increases))