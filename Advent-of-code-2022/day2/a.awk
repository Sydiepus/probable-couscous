{
	if ($2 == "X") {
		score += 1
		if ($1 == "A") {
			rscore += 3
		}
		else if ($1 == "B") {
			rscore += 1
		}
		else if ($1 == "C") {
			rscore += 2
		}
	}
	else if ($2 == "Y") {
		score += 2
		rscore += 3
		if ($1 == "A") {
			rscore += 1
		}
		else if ($1 == "B") {
			rscore += 2
		}
		else if ($1 == "C") {
			rscore += 3
		}	
	}
	else if ($2 == "Z") {
		score += 3
		rscore += 6
		if ($1 == "A") {
			rscore += 2
		}
		else if ($1 == "B") {
			rscore += 3
		}
		else if ($1 == "C") {
			rscore += 1
		} 
	}
	if (($1 == "A" && $2 == "X") || ($1 == "B" && $2 == "Y") || ($1 == "C" && $2 == "Z")) {
		score += 3
	}
	else if (($1 == "A" && $2 == "Y") || ($1 == "B" && $2 == "Z") || ($1 == "C" && $2 == "X")) {
		score += 6
	}
}
END {
	print "Part 1: " score
	print "Part 2: " rscore
}
