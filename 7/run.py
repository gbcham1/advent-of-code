with open('puzzle-input', 'r') as f:
    puzzle = f.read().splitlines()

def cdup(pwd):
    parent_folder = '/'.join(pwd.split("/")[:-1])
    folders[parent_folder] += folders[pwd]
    return '/'.join(pwd.split("/")[:-1])

def cd(pwd, target):
    if args[2] == "..":
        pwd = cdup(pwd)
    else:
        pwd += "/" + target
    return pwd

pwd = ""
folders = dict()
for line in puzzle:
    args = line.split()
    if args[1] == "ls" or line == "$ cd /": continue
    if args[1] == "cd":
        pwd = cd(pwd, args[2])
    else:
        if pwd not in folders:
            folders[pwd] = 0
        if args[0] != "dir":
            folders[pwd] += int(args[0])

while pwd:
    pwd = cdup(pwd)

print(sum([folders[i] for i in folders if folders[i] < 100000]))
required_space = 30000000 - (70000000 - folders[''])
print(min([i for i in folders.values() if i >= required_space]))

print(folders)