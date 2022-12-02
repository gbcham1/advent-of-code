#!/bin/bash

declare -A handPoints=(["X"]=1 ["Y"]=2 ["Z"]=3)
declare -A draws=(["A"]="X" ["B"]="Y" ["C"]="Z")
declare -A wins=(["A"]="Y" ["B"]="Z" ["C"]="X")
declare -A losses=(["A"]="Z" ["B"]="X" ["C"]="Y")

replacep2 () {
	if [[ $p2 == "X" ]]; then
		p2=${losses[$p1]}
	elif [[ $p2 == "Y" ]]; then
		p2=${draws[$p1]}
	else
		p2=${wins[$p1]}
	fi
}

solution () {
	declare -i score=$((0))
	while IFS= read -r round; do
		IFS=" "; read -ra hands <<< $round
		p1=${hands[0]};
		p2=${hands[1]};
		if [[ $1 == 2 ]]; then
			replacep2
		fi
		if [[ ${draws[$p1]} == $p2 ]]; then
			score+=3;
		elif [[ $p1 == "A" && $p2 == "Y" || $p1 == "B" && $p2 == "Z" || $p1 == "C" && $p2 == "X" ]]; then
			score+=6;
		fi
		score+=${handPoints[$p2]}
	done < puzzle-input
	echo $score
}

solution 1
solution 2
