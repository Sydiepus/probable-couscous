import os
import arrays

fn main() {
	p := os.read_lines("input")!
	mut cur_cal := 0
	mut cal_arr := []int{}
	for i in p {
		if i != ""{
			cur_cal += i.int()
		}
		else{
			cal_arr << cur_cal
			cur_cal = 0
		}
	}
	cal_arr.sort()
	println("Part 1 : ${cal_arr.last()}")
	println("Part 2 : ${arrays.sum<int>(cal_arr#[-3..])!}")

	/*println(cal_arr)*/
}