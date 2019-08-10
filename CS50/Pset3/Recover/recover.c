#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

typedef uint8_t BYTE;

int main(int argc, char *argv[])
{
    // ensure proper usage
    if (argc != 2)
    {
        fprintf(stderr, "Usage: ./recover image\n");
        return 1;
    }

    // // remember filename
    char *infile = argv[1];

    // open infile
    FILE *forensicImage = fopen(infile, "r");
    if (forensicImage == NULL)
    {
        fprintf(stderr, "Could not open %s.\n", infile);
        return 2;
    }

    FILE *recoveredImage = NULL;

    // create an empty array of 512 bytes
    BYTE buffer[512];
    // number of images that have been found
    int count = 0;
    // name of file has 8 characters, length = 7
    char filename[8];

    // while end of file hasn't reached, repeat this loop
    while (!feof(forensicImage))
    {
        // Read the first 512 bytes in the file, forensicImage
        fread(buffer, 1, 512, forensicImage);

        // Once end of file has been reached, immediately exit
        if (feof(forensicImage))
        {
            break;
        }
        // Once another Jpeg file has been found
        if ((buffer[0] == 0xff &&
            buffer[1] == 0xd8 &&
            buffer[2] == 0xff &&
            (buffer[3] & 0xf0) == 0xe0) &&
            recoveredImage != NULL)
        {
            // close the current recoveredImage
            fclose(recoveredImage);
            // Increase the count of number of Jpeg images found
            count++;
        }

        // If a Jpeg image is found,
        if (buffer[0] == 0xff &&
            buffer[1] == 0xd8 &&
            buffer[2] == 0xff &&
            (buffer[3] & 0xf0) == 0xe0)
        {
            // name the file using count
            sprintf(filename, "%03i.jpg", count);
            // ope the file
            recoveredImage = fopen(filename, "w");
        }

        // write all 512 bytes while file is open
        if (recoveredImage != NULL)
        {
            fwrite(buffer, 1, 512, recoveredImage);
        }
    }

    // close last recoveredImage
    fclose(recoveredImage);

    // close forensicImage
    fclose(forensicImage);

    // Success!
    return 0;
}
