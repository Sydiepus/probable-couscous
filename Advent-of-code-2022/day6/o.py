def solve(line, ind, chunk):
    while ind + chunk !=len(line):
        marker = line[ind:ind+chunk] 
        for c in marker :
            if marker.count(c) > 1:
                ind += 1
                break
            else:
                if c == marker[-1]:
                    return ind + chunk
                    print(f"Part 1: {ind + 4}")

with open("input", "r") as f:
    data = f.readline()
    print(f"Part 1 : {solve(data, 0, 4)}")
    print(f"Part 2 : {solve(data, 0, 14)}")