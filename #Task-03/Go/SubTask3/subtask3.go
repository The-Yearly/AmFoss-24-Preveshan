package main

import (
	"fmt"
	"strings"
)

func main() {
	var n int
	fmt.Print("Enter n: ")
	fmt.Scan(&n)
	if n%2 != 0 {
		c := n - (n / 2) - 1
		fmt.Println(c)
		m := 1
		s1 := -1
		s2 := 1

		for g := 0; g < n; g++ {
			if c != 0 {
				fmt.Printf(strings.Repeat(" ", c))
			}
			fmt.Println(strings.Repeat("*", m))
			m += s2 * 2
			c += s1
			if c == 0 {
				s1 = 1
			}
			if m > n {
				s2 = -1
				m = n - 2
			}
		}
	} else {
		fmt.Println("Enter an odd number")
	}

}
