all: assemble linking running

clean:
	rm exit.o exit
assemble:
	as exit.s -o exit.o
linking:
	ld exit.o -o exit
running:
	./exit
