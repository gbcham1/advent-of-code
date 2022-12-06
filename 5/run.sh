remove_from_string() {
    # arg 1 regex, arg 2:: string
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

# still needs a proper solution
declare -a puzzle=()
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
        # load string into array
        remove_from_string '(.*)[a-zA-Z]+(.*)' $line
        s=($filteredString)
        # IFS=" " read -r n f t < <(echo $filteredString) # slow because it spawns a subshell, but reads into nicer variables 

        # pop moving crates into new variable and update origin crate
        revstr=""
        fromcrate=${puzzle[${s[1]}]}
        for ((i=1; i<=${s[0]}; i++)); do
            revstr+=${fromcrate: -1}
            fromcrate=${fromcrate%?}
        done
        puzzle[${s[1]}]=$fromcrate

        # solution 2 adds in reverse
        if [[ $1 == "2" ]]; then
            reverse_string $revstr
        fi
        puzzle[${s[2]%?}]+=$revstr
    done < puzzle-input

    # print solution
    s=""
    for ((i=1; i<=9; i++)); do
        t=${puzzle[$i]}
        s+=${t: -1}
    done
    echo $s
}

load
solution 1

load
solution 2