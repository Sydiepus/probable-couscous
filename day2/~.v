import os
/* A: 65 B: 66 C: 67
   X: 88 Y: 89 Z: 90
   R     P     S
D   153   155   157
W   154   156   155
L   155   154   156
*/
fn main() {
	lines := os.read_lines("input")!
	mut score := 0
	mut rscore := 0
	for line in lines {
		sum := line[0] + line[2]
		if sum == 153 || sum == 157 || (sum == 155 && line[2] == 89){
			score += 3
		} 
		else if (sum == 154 && line[2] == 89) || (sum == 156 && line[2] == 90) || (sum == 155 && line[2] == 88) {
			score += 6
		}
		match line[2] {
			88{
				score += 1
				match line[0] {
					65 {
						rscore += 3
					}
					66 {
						rscore += 1
					}
					else {
						rscore += 2
					}
				}
			}
			89{
				score += 2
				rscore += 3
				match line[0] {
					65 {
						rscore += 1
					}
					66 {
						rscore += 2
					}
					else {
						rscore += 3
					}
				}
			}
			else {
				score += 3
				rscore += 6
				match line[0] {
					65 {
						rscore += 2
					}
					66 {
						rscore += 3
					}
					else {
						rscore += 1
					}
				}
			}
		}
	}
	println("Part 1 : ${score}")
	println("Part 2 : ${rscore}")
}