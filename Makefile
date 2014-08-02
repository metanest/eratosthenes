RM_F=/bin/rm -f

primes:	primes.o
	ld -e primes -dynamic-linker /libexec/ld-elf.so.1 -o primes /usr/lib/crt1.o /usr/lib/crti.o primes.o -L/usr/lib -lc /usr/lib/crtn.o

primes.o: primes.nas
	nasm -f elf64 -o primes.o primes.nas

clean:
	${RM_F} primes primes.o
