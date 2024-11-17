#ifndef KHEAP_H
#define KHEAP_H

#include <stddef.h>
#include <stdint.h>

/*
 * intializes heap
 */
void kheap_init();

/*
 * wrapper function for malloc for kernel heap
 * @param size size req from the heap
 * @returns *ptr start of the address
 */
void *kmalloc(size_t size);

/*
 * wrapper fn to free the memory in the kernel heap
 * @param *ptr ptr to the memory to free
 */
void kfree(void *ptr);

#endif
