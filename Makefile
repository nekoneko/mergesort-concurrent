CC = gcc
CFLAGS = -std=gnu99 -Wall -g -pthread
OBJS = list.o threadpool.o main.o

.PHONY: all clean test

GIT_HOOKS := .git/hooks/pre-commit

all: $(GIT_HOOKS) sort

$(GIT_HOOKS):
	@scripts/install-git-hooks
	@echo

deps := $(OBJS:%.o=.%.o.d)
txts := result.txt \
		tmpt.txt \
		reverse.txt

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -MMD -MF .$@.d -c $<

sort: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) -rdynamic

check:
	./sort && \
	tac result.txt > reverse.txt && \
		diff dictionary/words.txt reverse.txt

clean:
	rm -f $(OBJS) sort
	@rm -rf $(deps) $(txts)

-include $(deps)
