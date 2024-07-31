cflags = -g -Wall -pedantic-errors -D_GNU_SOURCE -Wno-switch -std=c2x

calc.exe : scanner.o main.o parser.o calc.o
	gcc $^ -o calc.exe -L/usr/lib/ -lfl

parser.c parser.h: parser.y
	bison -d parser.y
		
parser.o: parser.c scanner.h calc.h 
	gcc $(cflags) -c $<

scanner.o : scanner.c scanner.h parser.h
	gcc $(cflags) -c $<

scanner.c scanner.h : scanner.l parser.h
	flex -o$@ $<

calc.o: calc.c calc.h
	gcc $(cflags) -c $< 

main.o: main.c parser.h scanner.h calc.h
	gcc $(cflags) -c $<

clean : 
	rm -f scanner.c scanner.h scanner.o main.o calc.o parser.o calc.exe
