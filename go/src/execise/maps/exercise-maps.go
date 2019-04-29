package main

import (
	"strings"

	"golang.org/x/tour/wc"
)

func WordCount(s string) map[string]int {
	count := make(map[string]int)
	s_array := strings.Split(s, " ")
	for i := 0; i < len(s_array); i++ {
		if val, found := count[s_array[i]]; found {
			count[s_array[i]] = val + 1
		} else {
			count[s_array[i]] = 1
		}
	}
	return count
}

func main() {
	wc.Test(WordCount)
}
