from itertools import zip_longest

with open("input", "r") as f:
    lines = f.readlines()

def check_order(left, right):
    if type(left) is not None and right is None:
        return False
    elif left is None and type(right) is not None:
        return True
    elif type(left) is int and type(right) is int:
        if left < right:
            return True
        elif left == right:
            return None
        else:
            return False
    elif type(left) is list and type(right) is list:
        for l, r in zip_longest(left, right):
            res = check_order(l, r)
            if res is False:
                return False
            elif res is True:
                return True
    elif type(left) is list and type(right) is int:
        return check_order(left, [right])
    elif type(left) is int and type(right) is list:
        return check_order([left], right)

pair = 1
r_order = 0
for i in range(0,len(lines), 3):
    left = eval(lines[i].strip())
    right = eval(lines[i+1].strip())
    p = check_order(left, right)
    if p is True:
        r_order += pair
    pair += 1
print(f"Part 1 : {r_order}")

no_nw_line = list(filter(lambda x: x != "" ,map(lambda x: x.strip(), lines)))
no_nw_line.append("[[2]]")
no_nw_line.append("[[6]]")
def order(packet):
    total_order = 0
    for packet2 in no_nw_line:
        if check_order(eval(packet), eval(packet2)):
            total_order += 1
    return total_order

packet_order = sorted(no_nw_line, key=order, reverse=True)
divider_1 = packet_order.index("[[2]]") + 1 
divider_2 = packet_order.index("[[6]]") + 1
print(f"Part 2 : {divider_1 * divider_2}")
