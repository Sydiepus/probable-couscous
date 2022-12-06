import datatypes

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
			fluid.selements.push(fluid.elements.index(fluid.elements.len() - i)!)
		}
		fluid.switch = true
	}
	return true
}
struct Point {
	x int
	y int
}
fn main(){
	mut f := [Fluid[string]{}]
	f[0].push("a")
	f[0].push("b")
	f[0].push("c")
	f[0].push("c")
	f[0].push("c")
	f[0].push("c")
	println(f)
	f[0].to_stack()!
	println(f)
	//p := map[string]datatypes.Queue<int>{}
	//println(p)
}