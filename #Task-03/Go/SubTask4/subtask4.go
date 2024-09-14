package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	var n int
	input := "input.txt"
	output := "output.txt"
	content, err := os.ReadFile(input)
	n, erro := strconv.Atoi(string(content))
	if erro != nil {
		panic(erro)
	}
	if err != nil {
		fmt.Printf("Error reading from file %s: %v\n", input, err)
		return
	}
	if err != nil {
		fmt.Printf("Error reading from file %s: %v\n", input, err)
		return
	}
	if n%2 != 0 {
		var s string
		c := n - (n / 2) - 1
		m := 1
		s1 := -1
		s2 := 1

		for g := 0; g < n; g++ {
			if c != 0 {
				s += strings.Repeat(" ", c)
			}
			s += strings.Repeat("*", m)
			s += "\n"
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
		err = os.WriteFile(output, []byte(s), 0644)
		if err != nil {
			fmt.Printf("Error writing to file %s: %v\n", output, err)
			return
		}
	} else {
		fmt.Println("Enter an odd number")
	}

}
