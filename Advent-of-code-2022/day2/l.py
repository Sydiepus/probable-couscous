# A: 65 B: 66 C: 67
# X: 88 Y: 89 Z: 90
# R     P     S
# 153   155   157
# 154   156   155
with open("input", "r") as f:
    score = 0
    rscore = 0
    for i in f.readlines():
        sum = ord(i[0]) + ord(i[2])
        if sum == 153 or sum == 157 or (sum == 155 and ord(i[2]) == 89):
            score += 3
        elif (sum == 154 and ord(i[2]) == 89) or (sum == 156 and ord(i[2]) == 90) or (sum == 155 and ord(i[2]) == 88):
            score += 6
        # score += 1 if ord(i[2]) == 88 else 2 if ord(i[2]) == 89 else 3
        match ord(i[2]):
            case 88:
                score += 1
                match ord(i[0]):
                    case 65:
                        rscore += 3
                    case 66:
                        rscore += 1
                    case other:
                        rscore += 2
            case 89:
                score += 2
                rscore += 3
                match ord(i[0]):
                    case 65:
                        rscore += 1
                    case 66:
                        rscore += 2
                    case other:
                        rscore += 3
            case other:
              score += 3
              rscore += 6
              match ord(i[0]):
                    case 65:
                        rscore += 2
                    case 66:
                        rscore += 3
                    case other:
                        rscore += 1

    print(f"Part 1 : {score}", f"Part 2 : {rscore}", sep="\n")
