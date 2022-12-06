with open("puzzle-input", "r") as f:
    data = f.read()

def solution(marker, n):
    for i in range(len(marker)):
        cur = marker[i:i+n]
        if len(set(cur))==len(cur):
            print(i+n)
            break


solution(data, 4)
solution(data, 14)