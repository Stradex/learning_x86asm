all: assemble linking running

clean:
	rm recursive_func.o recursive_func
assemble:
	as --32 recursive_func.s -o recursive_func.o
linking:
	ld -m elf_i386 recursive_func.o -o recursive_func
running:
	./recursive_func
