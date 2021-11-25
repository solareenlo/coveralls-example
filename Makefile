NAME     := a.out

CC       := g++
CFLAGS   := -Wall -Wextra -Werror
CFLAGS   += -std=c++98 --pedantic
CFLAGS   += -fPIC -fprofile-arcs -ftest-coverage
RM       := rm -fr
SRCS     := main.cpp
OBJS     := main.o
COVERAGE := coverage

.PHONY: all
all: $(NAME)

$(NAME) : $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

$(OBJS) : $(SRCS)
	$(CC) $(CFLAGS) -o $@ -c $^

.PHONY: gcov
gcov: all
	gcov $(SRCS)

.PHONY: lcov
lcov: gcov
	./$(NAME)
	mkdir -p ./$(COVERAGE)
	lcov --capture --directory . --output-file ./$(COVERAGE)/lcov.info

.PHONY: report
report : lcov
	genhtml ./$(COVERAGE)/lcov.info --output-directory ./$(COVERAGE)

.PHONY: clean
clean:
	$(RM) $(NAME) *.o *.so *.gcno *.gcda *.gcov *.info $(COVERAGE)

.PHONY: re
re: clean all
