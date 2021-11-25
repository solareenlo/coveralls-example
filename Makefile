NAME     := a.out

CC       := clang++
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
gcov: $(SRCS)
	gcov $^

.PHONY: lcov
lcov: gcov
	lcov --capture --directory . --output-file lcov.info

.PHONY: report
report : lcov
	genhtml lcov.info --output-directory ./$(COVERAGE)

.PHONY: clean
clean:
	$(RM) $(NAME) *.o *.so *.gcno *.gcda *.gcov *.info $(COVERAGE)

.PHONY: re
re: clean all
