file = open("input.txt", "r")
lines = file.readlines()

balls = [int(i) for i in lines[0].strip().split(",")]

def extract_int(string) :
    new_string = []
    for i in string.split(" ") :
        if i == "" :
            continue
        else : 
            new_string.append(i)
    return new_string

#reference.
# [
# [['49-', '0-', '9-', '90-', '8-'],
#   ['41', '88', '56', '13', '6'],
#   ['17', '11', '45', '26', '75'],
#   ['29', '62', '27', '83', '36'],
#   ['31', '78', '1', '55', '38']], [[]..[].[]]]]

def sum(winner) :
    sum = 0
    for row in winner :
        for num in row :
            if not num.endswith("-") :
                sum += int(num)
    return sum

def check_win(all_boards) :
    index = 0
    for board in all_boards :
        # check horizontally.
        for row in board :
            strike = 0
            for i in row :
                if i.endswith("-") :
                    strike += 1
            if strike == 5 :
                return index
        for col in range(0, 5) :
            strike = 0
            for ro in range(0, 5) :
                a = board[ro][col]
                if board[ro][col].endswith("-") :
                    strike += 1
            if strike == 5 :
                return index
        index += 1

def win_last(all_boards, ball) :
    
    test = all_boards
    winner = check_win(test)
    if winner != None :
        while winner != None :
            test.pop(winner)
            winner = check_win(test)
    # if len(test) == 0 :
    #     print(all_boards)
    #     print(ball)
    return test

def solve(balls, all_boards, win="first") :
    new_all_board = []
    counter = 0
    old_ball = 0
    for ball in balls :
        if win == "first" :
            if counter % 5 == 0 and new_all_board != [] :
                winner = check_win(new_all_board[0])
                if winner != None :
                    return new_all_board[-1][winner], old_ball
        elif win == "last" and new_all_board != [] and all_boards != []:
            if len(all_boards) == 1 :
                all_boards = win_last(all_boards, old_ball)
                if len(all_boards) == 0 :
                    return new_board, old_ball #new_boards is now the oldest non [] list.
            all_boards = win_last(new_all_board[0], old_ball)
        boards = []
        for board in all_boards :
            new_board = []
            for row in board :
                ind = 0
                for num in row :
                    if num == str(ball) :
                        row[ind] = num + "-"
                    else :
                        row[ind] = num
                    ind += 1
                new_board.append(row)
            boards.append(new_board)
        new_all_board.append(boards)
        counter += 1
        old_ball = ball
    return new_all_board

board = []
all_boards = []
for i in range(2, len(lines)) :
    if lines[i] == "\n" :
        all_boards.append(board)
        board = []
        continue
    else :
        board.append(extract_int(lines[i].strip()))

first_winner, ball = solve(balls, all_boards)
print("final score : " + str(sum(first_winner) * ball))
last_winner, ball = solve(balls, all_boards, win="last")
print("final score (part 2) : " + str(sum(last_winner) * ball))