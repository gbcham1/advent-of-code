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

join_by () { 
    local IFS="$1"
    shift
    s="$*"
}

current_folder=""
declare -a folders;
while IFS= read -r line; do
    declare -a args=(${line%?})
    [[ ${line%?} == "$ ls" ]] && continue;
    if [[ ${line%?} == "$ cd /" ]]; then
        current_folder=""
        continue
    fi
    if [[ "${args[1]}" == "cd" ]]; then
        if [[ ${args[2]} == ".." ]]; then
            split / $current_folder
            # echo ${a[@]}
            # echo ${a[@]::-1}
            # join_by / ${a[@]::-1}
            # echo $s
        else
            current_folder+="_${args[2]}"
        fi
    else
        [[ -v folders[$current_folder] ]] && folders[$current_folder]=0
        if [[ "${args[0]}" != "dir" ]]; then
            echo ${folders[$current_folder]}
            echo $current_folder
            folders[$current_folder]+=$((${args[0]}))
        fi
    fi
done < puzzle-input-test

echo ${#folders[@]}

for i in ${folders[*]}; do
    echo $i
done