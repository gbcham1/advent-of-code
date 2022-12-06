solution () {
    for ((i=0; i<$((${#puzzle}-$1)); i++)); do
        cur=${puzzle:$i:$1}
        temp=""
        for ((c=0; c<${#cur}; c++)); do
            if [[ "$temp" == *"${cur:$c:1}"* ]]; then 
                break
            fi
            temp+=${cur:$c:1}
        done
        if [[ $cur == $temp ]]; then
            echo $(($i+$1))
            break
        fi
    done
}

regex_solution () {
    # not working (yet), substitution not matching but regex is valid on https://www.regextester.com/
    # more elegant solution
    for ((i=0; i<$((${#puzzle}-$1)); i++)); do
        if [[ ${puzzle:$i:$1} =~ ^(?:([A-Za-z])(?!.*\1))*$ ]]; then
            echo $(($i+$1))
        fi
    done
}

read -r puzzle < puzzle-input

regex_solution 4
regex_solution 14

solution 4
solution 14