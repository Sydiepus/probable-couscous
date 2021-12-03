file = open("input.txt", "r")
lines = [i.strip() for i in file.readlines()]
length = len(lines[0])

#function to calculate the most common bit.
def calc_bits(list, index, check=None) :
    one = 0
    zero = 0
    for i in list :
        if i[index] == "1" :
            one += 1
        if i[index] == "0" :
            zero += 1
    if check == None :
        if one > zero :
            gamma = "1"
        else :
            gamma = "0"
    elif check == "ox" :
        if one >= zero :
            gamma = "1"
        else : 
            gamma = "0"
    #here we calculate the least common for the co2.
    elif check == "co" :
        if one >= zero :
            gamma = "0"
        else : 
            gamma = "1"
    return gamma

#function to flip the bits to get epsilon.
def flip_bit(bits) :
    flipped = ""
    for i in bits :
        if i == "1" :
            flipped += "0"
        if i == "0" :
            flipped += "1"
    return flipped

#Part 2: function to filter all unneeded data for the oxygen generator that is based on the most common bit.
def most_common_filter(list, index) :
    most_cmm = calc_bits(list, index, check="ox")
    most_cmm_list = []
    for i in list :
        if i[index] == most_cmm :
            most_cmm_list.append(i)
    if len(most_cmm_list) == 1 :
        return most_cmm_list[0]
    return most_common_filter(most_cmm_list, index + 1)

#Part 2: function to filter all unneeded data for the co2 scrubber that is based on the least common bit.
def least_common_filter(list, index) :
    least_cmm = calc_bits(list, index, check="co")
    least_cmm_list = []
    for i in list :
        if i[index] == least_cmm :
            least_cmm_list.append(i)
    if len(least_cmm_list) == 1 :
        return least_cmm_list[0]
    return least_common_filter(least_cmm_list, index + 1) 

#initialize gamma to add the most common bit to it.
gamma = ""
#considering that all input have the same length.
for i in range(length) :
    gamma += calc_bits(lines, i)

#get the oxygen rating using the most_common_filter function.
oxy_rating = most_common_filter(lines, 0)

#get co2 rating using the least_common_filter function.
co_rating = least_common_filter(lines, 0)

#since the least common bit will be the NOT of the most common.
epsilon = flip_bit(gamma)

# part 1.
pwr = int(epsilon, 2) * int(gamma, 2)
print("power consumption : " + str(pwr))

#part 2.
lsprt = int(oxy_rating, 2) * int(co_rating, 2)
print("life support rating : " + str(lsprt))