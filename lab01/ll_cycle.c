#include <stddef.h>
#include "ll_cycle.h"
int ll_has_cycle(node *head) {
   node *toitose,*hare;
   hare=head;
   toitose=head;
   while(1){
      if(hare==NULL) break;
      if(hare->next==NULL){
	 break;

   }
      hare=hare->next;
      hare=hare->next;
      toitose=toitose->next;
      if(hare==NULL || toitose==NULL){
	 break;
      } 
      if(hare== toitose){
	 return 1;
      }
      }
   /* your code here */
    return 0;
    }
