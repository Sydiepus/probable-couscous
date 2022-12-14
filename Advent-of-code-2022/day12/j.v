import os { read_lines }
import datatypes { Queue, Set }
import arrays { min }

fn main() {
	lines := read_lines('input')!
	mut map_for_signal := [][]string{}
	mut row_s := 0
	mut col_s := 0
	mut row_e := 0
	mut col_e := 0
	mut poss_s := [][]int{}
	for line in lines {
		mut line_bytes := line.split('')
		if line_bytes.contains('S') {
			row_s = map_for_signal.len
			col_s = line_bytes.index('S')
			line_bytes[col_s] = 'a'
		}
		if line_bytes.contains('E') {
			row_e = map_for_signal.len
			col_e = line_bytes.index('E')
			line_bytes[col_e] = 'z'
		}
		// Part 2
		if line_bytes.contains('a') {
			row_a := map_for_signal.len
			col_a := line_bytes.index('a')
			poss_s << [row_a, col_a, 0]
			for i in col_a + 1 .. line_bytes.len {
				if line_bytes[i] == 'a' {
					poss_s << [row_a, i, 0]
				}
			}
		}
		map_for_signal << line_bytes
	}
	println('Part 1 : ${bfs(map_for_signal, [row_s, col_s, 0], [row_e, col_e])!}')
	// Part 2
	mut output := Set[int]{}
	for a in poss_s {
		output.add(bfs(map_for_signal, a, [row_e, col_e])!)
	}
	println('Part 2 : ${min(output.elements.keys().filter(it != -1))!}')
}

fn check_up(map_for_signal [][]string, cur_row int, cur_col int) []int {
	up := [cur_row - 1, cur_col]
	// up is higher by one elevation proceed.
	if (map_for_signal[cur_row][cur_col].bytes()[0] + u8(1)).ascii_str() >= map_for_signal[cur_row - 1][cur_col]
		|| map_for_signal[cur_row][cur_col] == map_for_signal[cur_row - 1][cur_col] {
		// you can move.
		return up
	} else {
		return [cur_row, cur_col]
	}
}

fn check_down(map_for_signal [][]string, cur_row int, cur_col int) []int {
	down := [cur_row + 1, cur_col]
	// down is higher by one elevation proceed.
	if (map_for_signal[cur_row][cur_col].bytes()[0] + u8(1)).ascii_str() >= map_for_signal[cur_row + 1][cur_col]
		|| map_for_signal[cur_row][cur_col] == map_for_signal[cur_row + 1][cur_col] {
		// you can move.
		return down
	} else {
		return [cur_row, cur_col]
	}
}

fn check_left(map_for_signal [][]string, cur_row int, cur_col int) []int {
	left := [cur_row, cur_col - 1]
	// left is higher by one elevation proceed.
	if (map_for_signal[cur_row][cur_col].bytes()[0] + u8(1)).ascii_str() >= map_for_signal[cur_row][cur_col - 1]
		|| map_for_signal[cur_row][cur_col] == map_for_signal[cur_row][cur_col - 1] {
		// you can move.
		return left
	} else {
		return [cur_row, cur_col]
	}
}

fn check_right(map_for_signal [][]string, cur_row int, cur_col int) []int {
	right := [cur_row, cur_col + 1]
	// up is higher by one elevation proceed.
	if (map_for_signal[cur_row][cur_col].bytes()[0] + u8(1)).ascii_str() >= map_for_signal[cur_row][cur_col + 1]
		|| map_for_signal[cur_row][cur_col] == map_for_signal[cur_row][cur_col + 1] {
		// you can move.
		return right
	} else {
		return [cur_row, cur_col]
	}
}

fn find_path(map_for_signal [][]string, row int, col int) [][]int {
	mut up := [row, col]
	mut down := [row, col]
	mut left := [row, col]
	mut right := [row, col]
	if row - 1 >= 0 {
		// you can check up.
		up = check_up(map_for_signal, row, col)
	}
	if row + 1 < map_for_signal.len {
		// you can check down.
		down = check_down(map_for_signal, row, col)
	}
	if col + 1 < map_for_signal[0].len {
		// you check to the right.
		right = check_right(map_for_signal, row, col)
	}
	if col - 1 >= 0 {
		// you can check to the left.
		left = check_left(map_for_signal, row, col)
	}
	return [up, down, left, right]
}

fn bfs(map_for_signal [][]string, pos_s []int, pos_e []int) !int {
	mut q := Queue[[]int]{}
	q.push(pos_s)
	mut visited := Set[string]{}
	visited.add('${pos_s[0]} ${pos_s[1]}')
	mut steps := 0
	for !q.is_empty() {
		// check for any possible moves.
		// and add them to the queue.
		// if they are not visited.
		ele := q.pop()!
		cur_pos := ele[0..2]
		steps = ele[2]
		if cur_pos == pos_e {
			// you have reached the end.
			return steps
		}
		steps++
		mut possible_moves := find_path(map_for_signal, cur_pos[0], cur_pos[1])
		for mut move in possible_moves {
			if !visited.exists('${move[0]} ${move[1]}') {
				visited.add('${move[0]} ${move[1]}')
				move << steps
				q.push(move)
			}
		}
	}
	return -1
}
