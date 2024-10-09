all: assemble linking running

clean:
	rm max_number.o max_number
assemble:
	as max_number.s -o max_number.o
linking:
	ld max_number.o -o max_number
running:
	./max_number
