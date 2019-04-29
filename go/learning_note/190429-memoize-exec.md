# 背景介绍
Memoize是一种加速程序计算的方法，原理是将过去计算过的输入及结果保存在缓存中，下次遇到相同输入就从缓存中直接读取，减少重复计算。Memoize的核心方法如下：
```go
type Memoize func(int) int
func Memoized (mf Memoize) Memoize {
    cache := make(map[int]int)
    return func(key int)int {
        if val, found :=cache[key]; found {
            return val
        }
        temp := mf(key)
        cache[key] = temp
        return temp
    }
}
```
这段代码定义了一个接收int，返回int的函数类型Memoize，构建了一个接收Memoize类型函数，返回Memoize类型函数的函数，他在原有函数的基础上增加了一个map类的cache。把每次调用函数的输入和输出保存在cache里面，当再次遇到相同输入时直接读取cache，减少计算量。
abcdefghijklmnopqrstuvwxyz
# 应用场景
构筑fib函数：
```go
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
```
按<<Learning_Functional_Programming_in_Go>>中指导构建调用缓存调用函数
```go
func FibMemoized(n int) int {
	fibMem = Memoize(fib)
	return fibMem(n)
}
```
发现这样构筑的FibMemoized每次调用的时候cache都是空的，并不会缓存计算结果。
于是将该段代码替换成`var FibMemoized = Memoize(fib)`后，cache缓存可以正常使用。


# 存在问题
上节中的fib函数时递归的，实际被加入cache的仅有main中调用的输入，fib递归调用的输入并不会存入缓存。

# 是否可以重构fib？
在main之外键入`fib = Memoized(fib)`系统提示语法错误“在函数架构外使用非声明语句”，若用`var fib = Memoized(fib)`，则系统提示fib被重复声明。
在main中键入`var fib = Memoize(fib)`可以正常运行，但递归调用的输入仍不会存入缓存。

# 各个memoize版函数间缓存是否共享？
为回答这个问题，构建了一个测试函数
```go
func Test(x int) int {
	return x * 1000
}
var TestMemoized = Memoize(Test)
```
在main中交替调用FibMemoized和TestMemoized
```go
	fmt.Println(FibMemoized(8))
	fmt.Println(TestMemoized(8))
	fmt.Println(FibMemoized(8))
	fmt.Println(TestMemoized(8))
```
结果如下：
```
map[]
map[8:21]
21
map[]
map[8:8000]
8000
map[8:21]
caching
21
map[8:8000]
caching
8000
```
可以看出两个函数并没有共享cache
# 完整代码
完整代码存放在go\src\fib\fib.go里面，代码如下：
```go
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
```