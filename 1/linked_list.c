#include <stdio.h>

// ill have to go back to the fundamentals to do this

// Define a double linked list of heap-allocated strings.
// Write functions to insert, find, and delete items from it. Test them.

// first, how do i create a pointer, and have it point to another pointer

typedef struct Node{
    // malloc a string
    struct Node *next;
}Node;

int main(){
    int c;
    while(1){
        printf("(1) Insert to list\n");
        printf("(2) Find item from list\n");
        printf("(3) Delete item from list\n");
        printf("(4) break from program\n");

        scanf("%d", &c);
        if(c == 4) break;
    }

    return 0;
}
