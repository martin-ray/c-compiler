#!/bin/bash
assert(){
    expected="$1"
    input="$2"

    ./9cc "$input" > tmp.s
    gcc -o tmp tmp.s
    ./tmp
    actual="$?"

    if [ "$actual" = "$expected" ];then
        echo "$input => $actual"
    else
        echo "$input => $expected expected, but got $actual"
        exit 1
    fi
}

assert 0 0
assert 42 42
assert 41 41
assert 77 77
assert 55 55
assert 122 122
# 足し算引き算を追加
assert 21 "5+20-4"
# The compiler tokenize the input
assert 21 "5   + 20      -4"
echo OK