all: assemble linking running

clean:
	rm bubble_sort.o bubble_sort
assemble:
	as --32 bubble_sort.s -o bubble_sort.o
linking:
	ld -m elf_i386 bubble_sort.o -o bubble_sort
running:
	./bubble_sort
