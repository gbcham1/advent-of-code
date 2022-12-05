#     [D]    
# [N] [C]    
# [Z] [M] [P]
#  1   2   3 

remove_from_string() {
    # arg 1 regex, arg 2 string
    # '(.*)[a-zA-Z]+(.*)' removes all letters
    local re=$1
    local s=${@:2}
    while [[ $s =~ $re ]]; do
        s=${BASH_REMATCH[1]}${BASH_REMATCH[2]}
    done
    filteredString=$s
}

reverse_string() {
    revstr=""
    local s=$1
    n=${#s}
    for (( i=$n-1; i>=0; i-- )); do
        revstr=$revstr${s:$i:1}
    done
}

declare -a puzzle=()
# [C]         [S] [H]                
# [F] [B]     [C] [S]     [W]        
# [B] [W]     [W] [M] [S] [B]        
# [L] [H] [G] [L] [P] [F] [Q]        
# [D] [P] [J] [F] [T] [G] [M] [T]    
# [P] [G] [B] [N] [L] [W] [P] [W] [R]
# [Z] [V] [W] [J] [J] [C] [T] [S] [C]
# [S] [N] [F] [G] [W] [B] [H] [F] [N]
#  1   2   3   4   5   6   7   8   9 
load () {
    puzzle[1]="SZPDLBFC"
    puzzle[2]="NVGPHWB"
    puzzle[3]="FWBJG"
    puzzle[4]="GJNFLWCS"
    puzzle[5]="WJLTPMSH"
    puzzle[6]="BCWGFS"
    puzzle[7]="HTPMQBW"
    puzzle[8]="FSWT"
    puzzle[9]="NCR"
}

solution () {
    while IFS= read -r line; do
        if [[ $line != "move"* ]]; then continue; fi
        # load string
        remove_from_string '(.*)[a-zA-Z]+(.*)' $line
        s=($filteredString)

        # pop moving crates into new variable and update origin crate
        movers=""
        tocrate=${puzzle[${s[2]%?}]}
        fromcrate=${puzzle[${s[1]}]}
        for ((i=1;i<=$((${s[0]}));i++)); do
            movers+=${fromcrate: -1}
            fromcrate=${fromcrate%?}
        done
        puzzle[${s[1]}]=$fromcrate

        # add crates in temp variable to destination crate
        revstr=$movers # var failsafe is solution 1
        if [[ $1 == "2" ]]; then
            reverse_string $movers
        fi
        tocrate+=$revstr
        puzzle[${s[2]%?}]=$tocrate
    done < puzzle-input

    # print solution
    s=""
    for ((i=1;i<=${#puzzle[@]};i++)); do
        t=${puzzle[$i]}
        s+=${t: -1}
    done
    echo $s
}

load
solution 1
load
solution 2