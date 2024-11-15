FILES = ./build/kernelASM.o ./build/kernel.o
INCLUDES = -I./src
FLAGS = -g -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-cpp -Wno-unused-parameter -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc
all: ./bin/boot.bin ./bin/kernel.bin
	rm -rf ./bin/os.bin
	dd if=./bin/boot.bin >> ./bin/os.bin
	dd if=./bin/kernel.bin >> ./bin/os.bin
	dd if=/dev/zero bs=512 count=100 >> ./bin/os.bin

./bin/kernel.bin: $(FILES)
	i386-elf-ld -g -relocatable $(FILES) -o ./build/kernelfull.o
	i386-elf-gcc $(FLAGS) -T ./src/linker.ld -o ./bin/kernel.bin -ffreestanding -O0 -nostdlib ./build/kernelfull.o

./bin/boot.bin: ./src/boot/boot.asm
	nasm -f bin ./src/boot/boot.asm -o ./bin/boot.bin

./build/kernelASM.o: ./src/kernel/kernel.asm
	nasm -f elf -g ./src/kernel/kernel.asm -o ./build/kernelASM.o

./build/kernel.o: ./src/kernel/kernel.c
	i386-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c ./src/kernel/kernel.c -o ./build/kernel.o

run:
	qemu-system-x86_64 -hda ./bin/os.bin

clean: 
	rm -rf ./bin/*
	rm -rf ./build/*
