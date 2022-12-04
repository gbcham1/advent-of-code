readarray -t puzzle < puzzle-input

# Taken from SO for speed https://stackoverflow.com/questions/10586153/how-to-split-a-string-into-an-array-in-bash
split(){
    a=()
    local car=""
    local cdr="$2"
    while
        car="${cdr%%"$1"*}"
        a+=("$car")
        cdr="${cdr:${#car}}"
        (( ${#cdr} ))
    do
        cdr="${cdr:${#1}}"
    done
}

solution() {
    declare -i total=0
    for pair in "${puzzle[@]}"; do
        split , $pair
        e1=${a[0]}
        e2=${a[1]}
        split - $e1
        declare -i e1s=${a[0]}
        declare -i e1e=${a[1]}
        split - $e2
        declare -i e2s=${a[0]}
        declare -i e2e=${a[1]%?} # hack for trimming weird newline behaviour
        if [[ $1 = "1" ]]; then
            if [[ $e1s -ge $e2s && $e1e -le $e2e || $e2s -ge $e1s && $e2e -le $e1e ]]; then
                total+=1
            fi
        elif [[ $1 = "2" ]]; then
            if [[ $e1e -ge $e2s && $e1s -le $e2e || $e2e -ge $e1s && $e2s -le $e1e ]]; then
                total+=1
            fi
        fi
    done
    echo $total
}

solution 1
solution 2