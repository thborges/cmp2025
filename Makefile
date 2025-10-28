all:
	flex calc.l
	bison -d calc.y
	clang++ -std=c++20 -g -O1 *.c -o calc 
