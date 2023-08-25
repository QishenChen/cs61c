/************************************************************************
**
** NAME:        imageloader.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Dan Garcia  -  University of California at Berkeley
**              Copyright (C) Dan Garcia, 2020. All rights reserved.
**              Justin Yokota - Starter Code
**				YOUR NAME HERE
**
**
** DATE:        2020-08-15
**
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
#include "imageloader.h"

//Opens a .ppm P3 image file, and constructs an Image object. 
//You may find the function fscanf useful.
//Make sure that you close the file with fclose before returning.
Image *readData(char *filename) 
{
   FILE *fp=fopen(filename,"r");
   if(fp==NULL) return NULL;
   char c[10];
   fscanf(fp,"%s\n",c);
   int row,coloumn,Color_value;
   fscanf(fp,"%d%d%d\n",&coloumn,&row,&Color_value);
   Image *new_image=(Image*)malloc(sizeof(Image*));
   new_image->cols=coloumn;
   new_image->rows=row;
   int pixels=row*coloumn;
   new_image->image=(Color**)malloc(pixels*sizeof(Color*));
   for(int i=0;i<pixels;i++){
      *(new_image->image+i)=(Color*)malloc(sizeof(Color));
      Color* this_pixel=*(new_image->image+i);
      fscanf(fp, "%hhu %hhu %hhu", &this_pixel->R, &this_pixel->G, &this_pixel->B);
   }
  fclose(fp);
   return new_image;
}

//Given an image, prints to stdout (e.g. with printf) a .ppm P3 file with the image's data.
void writeData(Image *image)
{
		
   puts("P3");
   printf("%d %d\n",image->cols,image->rows);
   puts("255");
   Color** p=image->image;
   for(int i=0;i<image->rows;i++){
      for(int j=0;j<image->cols-1;j++){
         printf("%3hhu %3hhu %3hhu   ",(*p)->R, (*p)->G, (*p)->B);
         p++;
      }
         printf("%3hhu %3hhu %3hhu\n",(*p)->R, (*p)->G, (*p)->B);
         p++;
      }
   puts(" ");
   }

//Frees an image
void freeImage(Image *image)
{
   for(int i=0;i<image->rows;i++){
      free(image->image[i]);

   }
   free(image->image);
   free(image);
}
