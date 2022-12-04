#!/bin/bash

#declare -a priorities=(["a"]=1)
declare -i i=1
declare -A priorities
readarray -t puzzle < puzzle-input
for char in $(echo {a..z}); do
	priorities["$char"]=$i
	i+=1
done
for char in $(echo {A..Z}); do
	priorities["$char"]=$i
	i+=1
done

splitstring () {
	declare inv=$1
	part1=${inv:0:${#inv}/2}
	part2=${inv:${#inv}/2}
}

solution1 () {
	declare -i total=0
	for rucksack in "${puzzle[@]}"; do
		declare -a seen=()
		splitstring $rucksack
		while [ -n "$part1" ]; do
			next=${part1#?}
			letter="${part1%$next}"
			if [[ "$part2" == *"$letter"* &&  $(echo ${seen[@]} | grep -o $letter | wc -w) == "0" ]]; then
				seen+=("$letter")
			fi
			part1=$next
		done
		declare -i i=1
		for letter in ${seen[@]}; do
			total+=${priorities[$letter]}
		done
#                if [[ $1 == 2 ]]; then
#                        # sol2
#                fi
    done < puzzle-input
	echo $total
}

solution2 () {
	let i=-1;
	declare -i total=0;
	for rucksack in "${puzzle[@]}"; do
		let i+=1
		if [[ $(($i%3)) != 0 ]]; then continue; fi
		r1="${puzzle[$i]}"
		r2="${puzzle[$i+1]}"
		r3="${puzzle[$i+2]}"
		while [ -n "$r1" ]; do
			next=${r1#?}
			letter="${r1%$next}"
			if [[ "$r2" == *"$letter"* && "$r3" == *"$letter"* ]]; then
				total+=${priorities[$letter]}
				break
			fi
			r1=$next
		done
	done
	echo $total
}

solution1
solution2
