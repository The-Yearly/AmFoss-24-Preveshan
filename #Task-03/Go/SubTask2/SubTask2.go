package main

import (
	"fmt"
	"os"
)

func main() {
	input := "input.txt"
	output := "output.txt"
	content, err := os.ReadFile(input)
	if err != nil {
		fmt.Printf("Error reading from file %s: %v\n", input, err)
		return
	}
	err = os.WriteFile(output, content, 0644)
	if err != nil {
		fmt.Printf("Error writing to file %s: %v\n", output, err)
		return
	}
}
