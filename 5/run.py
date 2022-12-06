from string import ascii_uppercase

with open("puzzle-input", "r") as f:
    data = f.read()
    cratestring, moves = data.split("\n\n")

def load_crates():
    number_of_crates = len(cratestring.splitlines()[-1].split())
    crates = {n+1:[] for n in range(number_of_crates)}
    for level in cratestring.splitlines()[:-1]:
        i = 0
        for char in level[1::4]:
            if char in ascii_uppercase:
                crates[i+1].insert(0,char)
            i += 1
    return crates

def solution(s):
    for move in moves.splitlines():
        n, a, b = (int(x) for x in move.split()[1::2])
        movers = []
        for i in range(n):
            movers.append(crates[a].pop())
        if s == 1:
            for crate in movers:
                crates[b].append(crate)
        elif s == 2:
            for crate in movers[::-1]:
                crates[b].append(crate)
    print("Top Crates: %s" % ''.join([stack[-1] for stack in crates.values()]))


if __name__=="__main__":
    crates = load_crates()
    solution(1)

    crates = load_crates()
    solution(2)