package main

import "fmt"

func CalculateTotal(items []int) int {
	sum := 0
	for _, val := range items {
		sum += val
	}
	return sum
}

func main() {
	fmt.Println("DevWeave Go Sample Running")
}
