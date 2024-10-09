all: assemble linking running

clean:
	rm power_func.o power_func
assemble:
	as --32 power_func.s -o power_func.o
linking:
	ld -m elf_i386 power_func.o -o power_func
running:
	./power_func
