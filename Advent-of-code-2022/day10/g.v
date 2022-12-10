import os
import arrays

fn check_signal_strength(cycle int, x int, mut signal_strength []int) {
	match cycle {
		20 {
			signal_strength << x * 20	
		}
		60 {
			signal_strength << x * 60	
		}
		100 {
			signal_strength << x * 100	
		}
		140 {
			signal_strength << x * 140	
		}
		180 {
			signal_strength << x * 180	
		}
		220 {
			signal_strength << x * 220	
		}
		else {}
	}
}

fn move_sprite(mut sprite []string, x int) {
	mut tmp_sprite := []string{len: 40, init: "."}
	if x < 0 {
		// fix for row 2 and 3 extra #
		sprite = tmp_sprite.clone()
		return
	}
	if x - 1 >= 0 && x + 1 <= 39 {
		// you can place all 3 #
		tmp_sprite[x-1] = "#"
		tmp_sprite[x] = "#"
		tmp_sprite[x+1] = "#"
	} else if x - 1 < 0 && x + 1 <= 39 {
		// place the middle one and the right one
		tmp_sprite[x] = "#"
		tmp_sprite[x+1] = "#"
	} else if x - 1 >= 0 && x + 1 > 39 {
		// place the middle one and the left one
		tmp_sprite[x-1] = "#"
		tmp_sprite[x] = "#"
	} else {
		// you can place the middle one only
		tmp_sprite[x] = '#'
	}
	sprite = tmp_sprite.clone()
}

fn place_pixel(mut screen [][]string, cycle int, sprite []string) {
	// on each cycle check if pixel at cycle - 1 is # in the sprite.
	if cycle >= 1 && cycle <= 40 {
		row := 0
		if screen[row][cycle - 1] != sprite[cycle - 1] {
			screen[row][cycle - 1] = "#"
		}
	} else if cycle >= 41 && cycle <= 80 {
		row := 1
		if screen[row][cycle - 41] != sprite[cycle - 41] {
			screen[row][cycle - 41] = "#"
		}
	} else if cycle >= 81 && cycle <= 120 {
		row := 2
		if screen[row][cycle - 81] != sprite[cycle - 81] {
			screen[row][cycle - 81] = "#"
		}
	} else if cycle >= 121 && cycle <= 160 {
		row := 3
		if screen[row][cycle - 121] != sprite[cycle - 121] {
			screen[row][cycle - 121] = "#"
		}
	} else if cycle >= 161 && cycle <= 200 {
		row := 4
		if screen[row][cycle - 161] != sprite[cycle - 161] {
			screen[row][cycle - 161] = "#"
		}
	} else if cycle >= 201 && cycle <= 240 {
		row := 5
		if screen[row][cycle - 201] != sprite[cycle - 201] {
			screen[row][cycle - 201] = "#"
		}
	}
}

fn main() {
	lines := os.read_lines("input")!
	mut cycle := 1
	mut x := 1
	mut signal_strength := []int{}
	//sprite ###
	mut sprite := []string{len: 40, init: "."}
	// set first 3 pixels to #
	sprite[0] = "#"
	sprite[1] = "#"
	sprite[2] = "#"
	// x sets the position of the middle #
	// screen is 40 wide 6 tall.
	mut screen := [][]string{len: 6, init: []string{len: 40, init: "."}}
	for line in lines {
		split_line := line.split(" ")
		instruction := split_line[0]
		if instruction == "addx" {
			// first cycle begins.
			place_pixel(mut screen, cycle, sprite)
			check_signal_strength(cycle, x, mut signal_strength)
			// Second cycle begins.
			cycle += 1
			place_pixel(mut screen, cycle, sprite)
			check_signal_strength(cycle, x, mut signal_strength)
			// End of second cycle.
			cycle += 1
			v := split_line[1].int()
			x += v
			move_sprite(mut sprite, x)
		} else {
			// first cycle begins.
			place_pixel(mut screen, cycle, sprite)
			check_signal_strength(cycle, x, mut signal_strength)
			cycle += 1
		}
	}
	println("Part 1 : ${arrays.sum<int>(signal_strength)!}")
	// some # might be missing in the first col.
	for i in screen {
		println(i.join(""))
	}
}