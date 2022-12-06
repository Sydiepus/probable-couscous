import os
import datatypes
//import arrays

fn main() {
	lines := os.read_lines("input")!
	// number of stacks on line 9.
	nb_of_stacks := lines[8]#[-2..][0].ascii_str().int()
	// create an array of stacks(queues) of type string
	//mut arr := []Fluid<string>{len: nb_of_stacks}
	mut stacks := map[string]Fluid<string>{}
	println(stacks)
	for line in lines {
		filtered_lines := line.replace("    ", " ").split(" ")
		//length of of the lines with containers is 9
		// length of the ones with the instructions is 6
		if filtered_lines.len == 9 {
			// place each element in stack(queue) in array at position of the current element index.
			for i in 0..nb_of_stacks {
				if filtered_lines[i] == "" {
					continue
				}
				// add str to queue
				stacks[i.str()].push(filtered_lines[i])
			}		
		}
		else if filtered_lines.len == 6 {			
			// ['move', '6', 'from', '8', 'to', '5']
			// 6 is nb of pop operations
			// 8 index of stack(queue) to pop from
			// 5 index of stack(queue) to push to
			// !! stack 8 is index 7 and stack 5 is at index 4 !!
			nb_pop := filtered_lines[1].int()
			index_pop := filtered_lines[3].int() - 1
			index_push := filtered_lines[5].int() - 1
			// make sure fluid at indexes is acting like stack before doing operation
			stacks[index_push.str()].to_stack()!
			stacks[index_pop.str()].to_stack()!
			for _ in 0..nb_pop {
				stacks[index_push.str()].push(stacks[index_pop.str()].pop()!)
			}
		}
	}
	/*// get the Last str from Queue and join it in an array of strings.
	mut msg := []string{}
	for i in 0..9 {
		msg << arr[i].last()!//.replace("[","").replace("]","")
	}
	println(msg)
	println(msg.join(""))*/
	println(stacks)
}

struct Fluid[T] {
	mut:
		elements datatypes.Queue[T]
		switch bool // 0 by default
		selements datatypes.Stack[T]
}

fn (mut fluid Fluid[T]) push(item T) {
	if fluid.switch {
		fluid.selements.push(item)
	} else {
		fluid.elements.push(item)
	}
}

fn (mut fluid Fluid[T]) pop() !T {
	if fluid.switch {
		return fluid.selements.pop()!
	} else{
		return fluid.elements.pop()!
	}
}

fn (fluid Fluid[T]) str() string {
	if fluid.switch {
		return fluid.selements.str()
	} else{
		return fluid.elements.str()
	}
}

// this function converts queue to stack
fn (mut fluid Fluid[T]) to_stack() !bool {
	if !fluid.switch {
		// convert queue to stack
		for i in 1..fluid.elements.len() + 1 {
			el := fluid.elements.index(fluid.elements.len() - i)!
			println(el)
			fluid.selements.push(el)
		}
		fluid.switch = true
	}
	return true
}