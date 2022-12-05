from string import ascii_uppercase


with open("puzzle-input", "r") as f:
    data = f.read()
    cratestring, moves = data.split("\n\n")


def load_crates():
    number_of_crates = len(cratestring.splitlines()[-1].split())
    crates = {n+1:[] for n in range(number_of_crates)}
    for level in cratestring.splitlines()[:-1]:
        i = 0
        for char in level:
            if char in ascii_uppercase:
                crates[i//4+1].insert(0,char)
            i += 1
    return crates


def solution_1():
    def move_crate(a, b):
        crate = crates[a].pop()
        crates[b].append(crate)

    for move in moves.splitlines():
        n, a, b = (int(x) for x in move.split()[1::2])
        for i in range(n):
            move_crate(a, b)
    print("Top Crates: %s" % ''.join([stack[-1] for stack in crates.values()]))


def solution_2():
    def move_multiple_crates(n, a, b):
        movers = []
        for crate in range(n):
            movers.append(crates[a].pop())
        for crate in movers[::-1]:
            crates[b].append(crate)

    for move in moves.splitlines():
        n, a, b = (int(x) for x in move.split()[1::2])
        move_multiple_crates(n, a, b)
    print("Top Crates: %s" % ''.join([stack[-1] for stack in crates.values()]))


if __name__=="__main__":
    crates = load_crates()
    solution_1()

    crates = load_crates()
    solution_2()