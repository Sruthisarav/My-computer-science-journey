// Copies a BMP file

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "bmp.h"

int main(int argc, char *argv[])
{
    // ensure proper usage
    if (argc != 4 || atof(argv[1]) < 0 || atof(argv[1]) >= 100)
    {
        fprintf(stderr, "Usage: ./resize f infile outfile\n");
        return 1;
    }

    // remember the size multiplier, a float.
    float f = atof(argv[1]);

    // remember filenames
    char *infile = argv[2];
    char *outfile = argv[3];

    // open input file
    FILE *inptr = fopen(infile, "r");
    if (inptr == NULL)
    {
        fprintf(stderr, "Could not open %s.\n", infile);
        return 2;
    }

    // open output file
    FILE *outptr = fopen(outfile, "w");
    if (outptr == NULL)
    {
        fclose(inptr);
        fprintf(stderr, "Could not create %s.\n", outfile);
        return 3;
    }

    // read infile's BITMAPFILEHEADER
    BITMAPFILEHEADER bf;
    fread(&bf, sizeof(BITMAPFILEHEADER), 1, inptr);

    // read infile's BITMAPINFOHEADER
    BITMAPINFOHEADER bi;
    fread(&bi, sizeof(BITMAPINFOHEADER), 1, inptr);

    // ensure infile is (likely) a 24-bit uncompressed BMP 4.0
    if (bf.bfType != 0x4d42 || bf.bfOffBits != 54 || bi.biSize != 40 ||
        bi.biBitCount != 24 || bi.biCompression != 0)
    {
        fclose(outptr);
        fclose(inptr);
        fprintf(stderr, "Unsupported file format.\n");
        return 4;
    }

    // new dimensions for biWidth and biHeight
    int old_biWidth = bi.biWidth;
    int old_biHeight = bi.biHeight;
    bi.biWidth = old_biWidth * f;
    bi.biHeight = old_biHeight * f;

    // determine padding for scanlines
    int old_padding = (4 - (old_biWidth * sizeof(RGBTRIPLE)) % 4) % 4;
    int new_padding = (4 - (bi.biWidth * sizeof(RGBTRIPLE)) % 4) % 4;

    // new dimensions for biSizeImage and bfSize
    bi.biSizeImage = ((sizeof(RGBTRIPLE) * bi.biWidth) + new_padding) * abs(bi.biHeight);
    bf.bfSize = bi.biSizeImage + sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER);

    // write outfile's BITMAPFILEHEADER
    fwrite(&bf, sizeof(BITMAPFILEHEADER), 1, outptr);

    // write outfile's BITMAPINFOHEADER
    fwrite(&bi, sizeof(BITMAPINFOHEADER), 1, outptr);

    // allocates temporary memory space for scanlines
    RGBTRIPLE *temporary_memory = malloc(sizeof(RGBTRIPLE) * (bi.biWidth));

    // for enlarging images
    if (f >= 1)
    {
        // iterate over infile's scanlines
        for (int i = 0, biHeight = abs(old_biHeight); i < biHeight; i++)
        {
            int count = 0;
            // iterate over pixels in scanline
            for (int j = 0; j < old_biWidth; j++)
            {
                // temporary storage
                RGBTRIPLE triple;

                // read RGB triple from infile
                fread(&triple, sizeof(RGBTRIPLE), 1, inptr);

                for (int k = 1; k <= f; k++)
                {
                    // store the pixel in the temporary_memory array
                    temporary_memory[count] = triple;
                    count++;
                }
            }

            // skip over padding, if any
            fseek(inptr, old_padding, SEEK_CUR);
            // rewriting a row of pixels for f number of times
            for (int n = 0; n < f; n++)
            {
                // write RGB triple to outfile
                fwrite(temporary_memory, sizeof(RGBTRIPLE), bi.biWidth, outptr);

                // Add padding to new image
                for (int m = 0; m < new_padding; m++)
                {
                    fputc(0x00, outptr);
                }
            }
        }
    }
    // for reducing size of image by factor f
    else if (f < 1)
    {
        int multiplier = round(1/f);
        // iterate over infile's scanlines
        for (int i = 0, biHeight = abs(old_biHeight); i < biHeight; i+= multiplier)
        {
            int count = 0;
            // iterate over pixels in scanline
            for (int j = 0; j < old_biWidth; j+= multiplier)
            {

                // temporary storage
                RGBTRIPLE triple;

                // read RGB triple from infile
                fread(&triple, sizeof(RGBTRIPLE), 1, inptr);

                // store the pixel in the temporary_memory array
                temporary_memory[count] = triple;
                count++;
                // skip (multiplier - 1) pixels
                fseek(inptr, sizeof(RGBTRIPLE) * (multiplier - 1), SEEK_CUR);
            }

            // skip over padding, if any
            fseek(inptr, old_padding, SEEK_CUR);

            // write RGB triple to outfile
            fwrite(temporary_memory, sizeof(RGBTRIPLE) * bi.biWidth, 1, outptr);

            // Add padding to new image
            for (int m = 0; m < new_padding; m++)
            {
                fputc(0x00, outptr);
            }
            // skip one row of pixels
            fseek(inptr, (old_biWidth * sizeof(RGBTRIPLE) + old_padding) * (multiplier - 1), SEEK_CUR);
        }
    }

    free(temporary_memory);

    // close infile
    fclose(inptr);

    // close outfile
    fclose(outptr);

    // success
    return 0;
}
