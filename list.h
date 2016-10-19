#ifndef LLIST_H_
#define LLIST_H_

#include <stdint.h>

typedef void *val_t;

typedef void (*print_funptr_t)(val_t , FILE *);

typedef struct node {
    val_t data;
    struct node *next;
} node_t;

typedef struct llist {
    node_t *head;
    uint32_t size;
} llist_t;

llist_t *list_new();
int list_add(llist_t *the_list, val_t val);
void list_print(llist_t *the_list, print_funptr_t print_funptr, FILE *fp);
node_t *list_nth(llist_t *the_list, uint32_t index);

#endif
