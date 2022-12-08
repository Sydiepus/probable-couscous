import os
import arrays

fn visible_direc(forest [][]int, row int, col int, direction string, mut score []int) !bool {
	tree := forest[row][col]
	mut trees_tmp := []int{}
	if direction == "up" {
		// check if the tree at forest[row][col] is greater than forest[row - 1][col] until forest[0][col], if yes return true.
		// we can extract all elements above and place them in an array.
		for i in 0 .. row {
			trees_tmp << forest[i][col]
		}
		// Part 2 
		//reverse array to keep it ordered like the input, the tree that is right next to the selected tree should the first tree in the array.
		trees_tmp.reverse_in_place()
	} else if direction == "down" {
		// check if the tree at forest[row][col] is greater than forest[row + 1][col] until forest[forest.len - 1][col], if yes return true.
		// we can extract all elements below and place them in an array.
		for i in row + 1 .. forest.len {
			trees_tmp << forest[i][col]
		}
	} else if direction == "left" {
		// check if the tree at forest[row][col] is greater than forest[row][0] until forest[row][col -1], if yes return true.
		// we can extract all elements to the left and place them in an array.
		for i in 0 .. col {
			trees_tmp << forest[row][i]
		}
		// Part 2 
		//reverse array to keep it ordered like the input, the tree that is right next to the selected tree should the first tree in the array.
		trees_tmp.reverse_in_place()
	} else if direction == "right" {
		// check if the tree at forest[row][col] is greater than forest[row][col + 1] until forest[row][forest.len - 1], if yes return true.
		// we can extract all elements to the left and place them in an array.
		for i in col + 1 .. forest.len {
			trees_tmp << forest[row][i]
		}
	}
	// count number of trees smaller than selected tree until you reach a tree greater or equal.
	// multiply that number with the score.
	mut count := 0
	for i in trees_tmp {
		if i >= tree {
			count++
			break
		} else {
			count++
		}
	}
	score[0] *= count
	// check if array contains the tree if yes then it's not visible return false.
	// else check if the max is less than the selected tree.
	if !trees_tmp.contains(tree){
		if arrays.max(trees_tmp)! < tree {
			return true
		} else {
			return false
		}
	} else {
		return false
	}
}

fn main() {
	//import input into a 2d array.
	lines := os.read_lines("input")!
	mut forest := [][]int{}
	// add each line to the forest.
	for line in lines {
		trees := line.split("")
		// convert trees to int and append them to the forest.
		forest << trees.map(it.int())
	}
	// visible trees counter
	mut visible := 0
	// these are the trees on the sides.
	// add nb of trees vertically * 2
	visible += forest.len * 2
	// add nb of trees horizontally * 2
	visible += forest[0].len * 2
	// remove the 1 visibility for each corner since they are included twice.
	visible -= 4
	// Part 2
	mut highest_score := [1]
	// Part 1
	for row in 1 .. forest.len - 1 {
		for col in 1 .. forest[0].len - 1 {
			// Part 2
			mut tmp_score := [1]
			// Part 1
			if visible_direc(forest, row, col, "up", mut tmp_score)! || visible_direc(forest, row, col, "down", mut tmp_score)! || visible_direc(forest, row, col, "left", mut tmp_score)! || visible_direc(forest, row, col, "right", mut tmp_score)! {
				visible += 1
			}
			// Part 2
			if tmp_score[0] > highest_score[0]{
				highest_score[0] = tmp_score[0]
			}
		}
	}
	println("Part 1 : ${visible}")
	println("Part 2 : ${highest_score[0]}")
}