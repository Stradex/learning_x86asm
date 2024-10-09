all: assemble linking running

clean:
	rm bubble_sort.o bubble_sort
assemble:
	as bubble_sort.s -o bubble_sort.o
linking:
	ld bubble_sort.o -o bubble_sort
running:
	./bubble_sort
