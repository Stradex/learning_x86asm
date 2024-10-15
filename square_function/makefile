all: assemble linking running

clean:
	rm square_func.o square_func
assemble:
	as --32 square_func.s -o square_func.o
linking:
	ld -m elf_i386 square_func.o -o square_func
running:
	./square_func
