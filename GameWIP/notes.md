as -o Space.o Space.s
as -o globals.o globals.s
ld -o Space Space.o globals.o
./Space
