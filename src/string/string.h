#ifndef STRING_H
#define STRING_H

#include <stdbool.h>
#include <stddef.h>
size_t strlen(const char *ptr);

size_t strnlen(const char *ptr, int max);

bool is_digit(char c);

int atoi(char c);

char *strcpy(char *dest, const char *src);

int strncmp(const char *str1, const char *str2, int n);

int istrncmp(const char *str1, const char *str2, int n);

char to_lower(char c);

int strnlen_terminator(const char *str, int max, char terminator);

#endif // !STRING_H
