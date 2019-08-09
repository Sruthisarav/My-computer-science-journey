# Questions

#NOTE: I searched online for some of the answers to some technical questions. 

## What's `stdint.h`?

The <stdint.h> header declares sets of integer types having specified widths, and defines corresponding sets of macros. It also defines macros that specify limits of integer types corresponding to types defined in other standard headers.

## What's the point of using `uint8_t`, `uint32_t`, `int32_t`, and `uint16_t` in a program?

They are: unsigned char, unsigned short, unsigned int and unsigned long long. They document our intent - we will be storing small numbers, instead of a character.

## How many bytes is a `BYTE`, a `DWORD`, a `LONG`, and a `WORD`, respectively?

BYTE: 1 byte
DWORD: 2 bytes
LONG: 4 bytes
WORD: 8 bytes

## What (in ASCII, decimal, or hexadecimal) must the first two bytes of any BMP file be? Leading bytes used to identify file formats (with high probability) are generally called "magic numbers."

Must contain the ASCII characters "B" and "M".

## What's the difference between `bfSize` and `biSize`?

bfsize is the size, in bytes, of a bitmap file while bisize is the number of bytes required by the structure.

## What does it mean if `biHeight` is negative?

If biHeight is negative, the bitmap is a top-down DIB and its origin is the upper-left corner.

## What field in `BITMAPINFOHEADER` specifies the BMP's color depth (i.e., bits per pixel)?

biBitCount

## Why might `fopen` return `NULL` in `copy.c`?

The name of infile given does not exist.

## Why is the third argument to `fread` always `1` in our code?

We are only trying to read 1 byte of the code at a time. 

## What value does `copy.c` assign to `padding` if `bi.biWidth` is `3`?

3

## What does `fseek` do?

It skips over padding if any

## What is `SEEK_CUR`?

It denotes file pointer's current location.
