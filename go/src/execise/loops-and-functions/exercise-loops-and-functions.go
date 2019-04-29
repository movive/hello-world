package main

import (
	"fmt"
)

func Sqrt(x float64) (z float64) {
	z = 1.0
	i := 1.0
	for i*i > 1e-20 {
		i = (z*z - x) / (2 * z)
		z = z - i
	}
	return
}

func main() {
	fmt.Println(Sqrt(2))
}
