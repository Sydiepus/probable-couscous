import os
import datatypes

fn main() {
	lines := os.read_lines('input')!
	mut sum := 0
	mut l_count := 0
	mut l_sum := 0
	mut f_line := datatypes.Set[u8]{}
	mut t_line := datatypes.Set[u8]{}
	mut s_line := datatypes.Set[u8]{}

	for line in lines {
		match l_count {
			0 {
				f_line.add_all(line.bytes())
				f_line.remove(13)
				f_line.remove(10)
				l_count += 1
			}
			1 {
				s_line.add_all(line.bytes())
				l_count += 1
			}
			2 {
				t_line.add_all(line.bytes())
				mut l_inter := f_line.intersection(s_line.intersection(t_line))
				l_char := l_inter.pop()!
				l_sum += priority(l_char)
				f_line.clear()
				s_line.clear()
				t_line.clear()
				l_count = 0
			}
			else {}
		}
		mut f_half := datatypes.Set[u8]{}
		f_half.add_all(line[..line.len / 2].bytes())
		mut s_half := datatypes.Set[u8]{}
		s_half.add_all(line[line.len / 2..].bytes())
		mut inter := f_half.intersection(s_half)
		c_char := inter.pop()!
		sum += priority(c_char)
	}
	println('Part 1 : ${sum}')
	println('Part 2 : ${l_sum}')
}

// if number <= 90 remove 64 and then add 26 = -38
// else remove 64 and then remove 32 = -96
// that's how you get the priority
fn priority(c int) int {
	mut val := c
	if c <= 90 {
		val -= 38
	} else {
		val -= 96
	}
	return val
}
