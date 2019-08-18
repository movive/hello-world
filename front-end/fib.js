function fib(n){
    console.log("n=",n);
    if (n===1 || n===0) {
        return n;
    }
    else {
        return setTimeout(()=>{return fib(n-1)+fib(n-2);},0);
    }
}
function fib1(n,total) {
    console.log("n=", n);
    if (n === 1 || n === 0) {
        return n;
    }
    else {
        return fib(n - 1) + fib(n - 2);
    }
}
let pow = (x,n)=>{
    let r = 1;
    let v = x;
    while(n) {
        if (n % 2 === 1) {
            r *= v;
            n -= 1;
        }
        v = v * v;
        n = n / 2;
        console.log("n=",n);
    }
    return r;
}