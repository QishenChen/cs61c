/************************************************************************
**
** NAME:        gameoflife.c
**
** DESCRIPTION: CS61C Fall 2020 Project 1
**
** AUTHOR:      Justin Yokota - Starter Code
**				YOUR NAME HERE
**
**
** DATE:        2020-08-23
**
**************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include "imageloader.h"

//Determines what color the cell at the given row/col should be. This function allocates space for a new Color.
//Note that you will need to read the eight neighbors of the cell in question. The grid "wraps", so we treat the top row as adjacent to the bottom row
//and the left column as adjacent to the right column.
Color* get_pixel(Image *image, int row, int col){
   Color** p= image->image;
   p+=(image->cols*row+col);
   return *p;
}
int lifeordeath(Image *image, int row, int col){
   Color* k= get_pixel(image, row, col);
   int b_pixel=k->B;
   return (b_pixel)&1;
}
Color*  remain(Image *image, int row, int col){
   Color* k;
   k=(Color*)malloc(sizeof(Color*));
   Color*  p=get_pixel(image, row, col);
   k->B=p->B;
   k->G=p->G;
   k->R=p->R;
   return k;
}
Color *turndead(){
   Color* k;
   k=(Color*)malloc(sizeof(Color*));
   k->B=0;
   k->G=0;
   k->R=0;
   return k;
}
Color *turnlive(){
   Color* k;
   k=(Color*)malloc(sizeof(Color*));
   k->B=255;
   k->G=255;
   k->R=255;
   return k;
}
Color *evaluateOneCell(Image *image, int row, int col, uint32_t rule)
{
  int cell_loc[3][3][2];
  for(int i=0;i<3;i++){
     cell_loc[i][0][1]=col-1;
     cell_loc[i][1][1]=col;
     cell_loc[i][2][1]=col+1;
     cell_loc[0][i][0]=row-1;
     cell_loc[1][i][0]=row;
     cell_loc[2][i][0]=row+1;
     if(col-1<0)
        cell_loc[i][0][1]=image->cols-1;
     if(col+1==image->cols)
	cell_loc[i][2][1]=0;
     if(row-1<0)
        cell_loc[0][i][0]=image->rows-1;
     if(row+1==image->rows)
	cell_loc[2][i][0]=0;
  }
  int tot=0;
  for(int i=0;i<3;i++)
     for(int j=0;j<3;j++)
	tot+=lifeordeath(image, cell_loc[i][j][0], cell_loc[i][j][1]);
  tot-=lifeordeath(image, row, col);
  if(lifeordeath(image, row, col)){
     if(!((rule>>(9+tot))&1)){
	return turndead();
     }
  }
  if(!lifeordeath(image, row, col)){
     if((rule>>tot)&1){
	return turnlive();
     }
  }
  return remain(image, row, col);

}

//The main body of Life; given an image and a rule, computes one iteration of the Game of Life.
//You should be able to copy most of this from steganography.c
Image *life(Image *image, uint32_t rule)
{
   Image* new_image=(Image*)malloc(sizeof(Image*));
   new_image->rows=image->rows;
   new_image->cols=image->cols;
   new_image->image=(Color**)malloc(sizeof(Color*)*image->rows*image->cols);
   Color ** p=new_image->image;
   for(int i=0;i<image->rows;i++){
      for(int j=0;j<image->cols;j++){
	 *p=evaluateOneCell(image,i ,j ,rule);
	 p++;
      }
   }
   return new_image;
}

/*
Loads a .ppm from a file, computes the next iteration of the game of life, then prints to stdout the new image.

argc stores the number of arguments.
argv stores a list of arguments. Here is the expected input:
argv[0] will store the name of the program (this happens automatically).
argv[1] should contain a filename, containing a .ppm.
argv[2] should contain a hexadecimal number (such as 0x1808). Note that this will be a string.
You may find the function strtol useful for this conversion.
If the input is not correct, a malloc fails, or any other error occurs, you should exit with code -1.
Otherwise, you should return from main with code 0.
Make sure to free all memory before returning!

You may find it useful to copy the code from steganography.c, to start.
*/
int main(int argc, char **argv)
{
   if(argc!=3)
      return -1;
   Image* input_image=readData(argv[1]);
   if(input_image==NULL) return -1;
   int rule=strtol(argv[2]+2, NULL, 16);
   Image* new_image=life(input_image,rule);
   writeData(new_image);
   freeImage(new_image);
   freeImage(input_image);
}
