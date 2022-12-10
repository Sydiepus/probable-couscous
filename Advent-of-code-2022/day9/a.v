import os

fn tail_in_range(tail map[string]int, head map[string]int) bool {
	// check if tail is above
	if head["x"] == tail["x"] && head["y"] == tail["y"] + 1 {
		return true
	// check if tail in upper right corner
	} else if head["x"] == tail["x"] + 1 && head["y"] == tail["y"] + 1 {
		return true
	// check if tail in upper left corner
	} else if head["x"] == tail["x"] - 1 && head["y"] == tail["y"] + 1 {
		return true
	// check if tail to the left
	} else if head["x"] == tail["x"] - 1 && head["y"] == tail["y"] {
		return true
	// check if tail lower left corner
	} else if head["x"] == tail["x"] - 1 && head["y"] == tail["y"] - 1 {
		return true
	// check if tail is below
	} else if head["x"] == tail["x"] && head["y"] == tail["y"] - 1 {
		return true
	// check if tail lower right corner
	} else if head["x"] == tail["x"] + 1 && head["y"] == tail["y"] - 1 {
		return true
	// check if tail is to the right
	} else if head["x"] == tail["x"] + 1 && head["y"] == tail["y"] {
		return true
	// check if tail overlap with head
	} else if head["x"] == tail["x"] && head["y"] == tail["y"] {
		return true
	// out of range return false
	} else {
		return false
	}
}

fn diagonal_move(mut tail map[string]int, head map[string]int) bool {
	// if tail not in same row or col of head it moves diagonally.
	if tail["x"] != head["x"] && tail["y"] != head["y"] {
		// if tail is a col before and a row below go to upper right corner.
		if tail["x"] < head["x"] && tail["y"] < head["y"] {
			tail["x"] += 1
			tail["y"] += 1
		// if tail is a col after and a row below go to upper left corner.
		} else if tail["x"] > head["x"] && tail["y"] < head["y"] {
			tail["x"] -= 1
			tail["y"] += 1
		// if tail is a col before and a row above go to lower right corner.
		} else if tail["x"] < head["x"] && tail["y"] > head["y"] {
			tail["x"] += 1
			tail["y"] -= 1
		//if tail is a col after and a row above go to lower left corner.
		} else if tail["x"] > head["x"] && tail["y"] > head["y"] {
			tail["x"] -= 1
			tail["y"] -= 1
		}
		return true
	}
	return false
}

fn d_pad_move(mut tail map[string]int, head map[string]int) {
	if tail["x"] == head["x"] {
		if head["y"] > tail["y"] {
			tail["y"] += 1
		} else {
			tail["y"] -= 1
		}
	} else if tail["y"] == head["y"] {
		if head["x"] > tail["x"] {
			tail["x"] += 1
		} else {
			tail["x"] -= 1
		}
	}
}

fn main() {
	lines := os.read_lines("input")!
	mut visited_1 := []map[string]int{}
	mut visited_2 := []map[string]int{}
	visited_1 << {"x": 0, "y": 0}.clone()
	visited_2 << {"x": 0, "y": 0}.clone()
	// initial coord 0, 0
	mut rope := []map[string]int{len:10, init: {"x": 0, "y": 0}}
	// index 0 the head
	// index 1 the tail for part 1
	// index 9 the tail for part 2
	for ins in lines {
		direc := ins.split(" ")[0]
		times := ins.split(" ")#[-1..][0].int()
		match direc {
			"U" {
				for _ in 0 .. times {
					rope[0]["y"] += 1
					for i in 0 .. 9 {
						if !tail_in_range(rope[i+1], rope[i]) {
							if !diagonal_move(mut rope[i+1], rope[i]) {
								d_pad_move(mut rope[i+1], rope[i])
							}
							if i+1 == 1 {
								if !visited_1.contains(rope[i+1]) {
									visited_1 << rope[i+1].clone()
								}
							} else if i+1 == 9 {
								if !visited_2.contains(rope[i+1]) {
									visited_2 << rope[i+1].clone()
								}
							}
						}
					}
				}
			}
			"D" {
				for _ in 0 .. times {
					rope[0]["y"] -= 1
					for i in 0 .. 9 {
						if !tail_in_range(rope[i+1], rope[i]) {
							if !diagonal_move(mut rope[i+1], rope[i]) {
								d_pad_move(mut rope[i+1], rope[i])
							}
							if i+1 == 1 {
								if !visited_1.contains(rope[i+1]) {
									visited_1 << rope[i+1].clone()
								}
							} else if i+1 == 9 {
								if !visited_2.contains(rope[i+1]) {
									visited_2 << rope[i+1].clone()
								}
							}
						}
					}
				}
			}
			"R" {
				for _ in 0 .. times {
					rope[0]["x"] += 1
					for i in 0 .. 9 {
						if !tail_in_range(rope[i+1], rope[i]) {
							if !diagonal_move(mut rope[i+1], rope[i]) {
								d_pad_move(mut rope[i+1], rope[i])
							}
							if i+1 == 1 {
								if !visited_1.contains(rope[i+1]) {
									visited_1 << rope[i+1].clone()
								}
							} else if i+1 == 9 {
								if !visited_2.contains(rope[i+1]) {
									visited_2 << rope[i+1].clone()
								}
							}
						}
					}
				}
			}
			"L" {
				for _ in 0 .. times {
					rope[0]["x"] -= 1
					for i in 0 .. 9 {
						if !tail_in_range(rope[i+1], rope[i]) {
							if !diagonal_move(mut rope[i+1], rope[i]) {
								d_pad_move(mut rope[i+1], rope[i])
							}
							if i+1 == 1 {
								if !visited_1.contains(rope[i+1]) {
									visited_1 << rope[i+1].clone()
								}
							} else if i+1 == 9 {
								if !visited_2.contains(rope[i+1]) {
									visited_2 << rope[i+1].clone()
								}
							}
						}
					}
				}
			}
			else {println("No match")}
		}
	}
	println("Part 1 : ${visited_1.len}")
	println("Part 2 : ${visited_2.len}")
}