split() {
    a=() # array to contain split strings
    local car="" # placeholder for items being added to array
    local cdr="$2" # string being split
    while
        car="${cdr%%"$1"*}" # returns longest match after delimiter from back of cdr
        a+=("$car") # add what was returned to array
        cdr="${cdr:${#car}}" # trim cdr down by length of extracted piece
        (( ${#cdr} )) # check if cdr still has length
    do
        cdr="${cdr:${#1}}" # set cdr to length 0 - kills the loop
    done
}

reverse_string() {
    revstr=""
    local s=$1
    n=${#s}
    for (( i=$n-1; i>=0; i-- )); do
        revstr=$revstr${s:$i:1}
    done
}

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

string_manipulation() {
    str="hello"
    echo ${str: -1} # o
    echo ${str: 1} # ello
    echo ${str%?} # hell
    echo ${#str} # 5
}