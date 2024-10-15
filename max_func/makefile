all: assemble linking running

clean:
	rm max_func.o max_func
assemble:
	as --32 max_func.s -o max_func.o
linking:
	ld -m elf_i386 max_func.o -o max_func
running:
	./max_func
