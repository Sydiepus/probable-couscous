class Monkey:
    def __init__(self, str_items: list, op: str, test: int, test_true: int, test_false: int):
        self.starting_items = str_items
        self.operation = op # include the operator and number.
        self.divisible = test
        self.test_true = test_true # number of monkey to thrown to.
        self.test_false = test_false # number of monkey to thrown to.
        self.inspections = 0

    def inspect_item(self, divide=True, finite_field=0):
        item = self.starting_items[0]
        self.starting_items.remove(item)
        item = self.do_operation(item, divide, finite_field)
        if finite_field:
            item %= finite_field
        self.inspections += 1
        # make test and throw to other monkey.
        return self.test(item)

    def do_operation(self, item, divide, finite_field):
        self.operation = list(map(lambda x: x.replace("old", "item"), self.operation))
        item = eval(" ".join(self.operation))        
        # after the operation the worry is divided by 3 and rounded
        # Please keep the number small.
        if divide:
            item //= 3
        return item

    def test(self, item):
        if item % self.divisible == 0 :
            return self.test_true, item
        else:
            return self.test_false, item
    
    def __len__(self):
        return len(self.starting_items)
    
    def append(self, item):
        self.starting_items.append(item)


with open("input", "r") as f:
    lines = f.readlines()

def fill_monkeys(lines):
    monkeys = []
    for i in range(0, len(lines), 7):
        strt_itm = list(map(int, lines[i+1].strip().split("Starting items: ")[1].split(",")))
        operation = lines[i+2].strip().split("Operation: new = ")[1].split(" ")
        test = int(lines[i+3].strip().split("Test: divisible by ")[1])
        test_true = int(lines[i+4].strip().split("If true: throw to monkey ")[1])
        test_false = int(lines[i+5].strip().split("If false: throw to monkey ")[1])
        monkeys.append(Monkey(strt_itm, operation, test, test_true, test_false))
    return monkeys

def solve_part_1():
    monkeys_list = fill_monkeys(lines)
    for _ in range(20):
        for monkey in monkeys_list:
            for _ in range(0, len(monkey)):
                mon_nb, item = monkey.inspect_item()
                monkeys_list[mon_nb].append(item)
    # multiply the highest two numbers of inscpected items.
    print(f"Part 1 : {max([monkey.inspections for monkey in monkeys_list]) * max([monkey.inspections for monkey in monkeys_list if monkey.inspections != max([monkey.inspections for monkey in monkeys_list])])}")

def solve_part_2():
    monkeys_list = fill_monkeys(lines)
    # finite field of divisible tests, hint used ;(
    p = 1
    for monkey in monkeys_list:
        p *= monkey.divisible
    for _ in range(10000):
        for monkey in monkeys_list:
            for _ in range(len(monkey)):
                mon_nb, item = monkey.inspect_item(divide=False, finite_field=p)
                monkeys_list[mon_nb].append(item)
    # multiply the highest two numbers of inscpected items.
    ins = [monkey.inspections for monkey in monkeys_list]
    ins.sort(reverse=True)
    print(f"Part 2 : {ins[0] * ins[1]}")

solve_part_1()
solve_part_2()

