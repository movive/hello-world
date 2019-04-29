package main

import (
	//	"fmt"
	"golang.org/x/tour/pic"
)

func Pic(dx, dy int) [][]uint8 {
	p := make([][]uint8, dx)
	for i := 0; i < dx; i++ {
		p[i] = make([]uint8, dy)
	}
	for i := 0; i < dx; i++ {
		for j := 0; j < dy; j++ {
			p[i][j] = uint8((i + j) / 2)
		}
	}
	return p
}
func main() {

	pic.Show(Pic)
}
