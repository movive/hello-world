package main

import (
	"fmt"
)

type Memoized func(int) int

func Memoize(mf Memoized) Memoized {
	cache := make(map[int]int)
	return func(key int) int {
		fmt.Println(cache)
		if val, found := cache[key]; found {
			fmt.Println("caching")
			return val
		}
		temp := mf(key)
		cache[key] = temp
		fmt.Println(cache)
		return temp
	}
}
func fib(x int) int {
	switch {
	case x < 1:
		return 0
	case x < 3:
		return 1
	default:
		return fib(x-1) + fib(x-2)
	}
}
func Test(x int) int {
	return x * 1000
}

/*
func FibMemoized(n int) int {
	fibMem = Memoize(fib)
	return fibMem(n)
}
func TestMemoized(n int) int {
	tesMem := Memoize(Test)
	return tesMem(n)
}
*/

var FibMemoized = Memoize(fib)
var TestMemoized = Memoize(Test)

func main() {
	/*
		var fib = Memoize(fib)
		var Test = Memoize(Test)

		fmt.Println(fib(8))
		fmt.Println(Test(8))
		fmt.Println(fib(8))
		fmt.Println(Test(8))
	*/

	fmt.Println(FibMemoized(8))
	fmt.Println(TestMemoized(8))
	fmt.Println(FibMemoized(8))
	fmt.Println(TestMemoized(8))

}
