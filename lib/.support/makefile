#
# Makefile for AtCoder
#

all: t

# select default programming language
PROG ?= java
#PROG ?= elixir
#PROG ?= ruby
#PROG ?= python
#PROG ?= c++

# Tools
EDITOR ?= code

RM = rm
#RM = trash

# OS Specific Tools
OS = $(shell uname -s)
OS_REL = $(shell uname -r)
ifeq ($(OS),Darwin)
# macOS
OPEN = open
else
ifeq ($(OS),Linux)
# Linux
OPEN = xdg-open
endif
endif

JAVAC = javac
JAVACFLAGS = -J-Dfile.encoding=UTF-8 -Xlint:unchecked -cp $(HOME)/lib/ac_library.jar
JAVA = java
JAVAFLAGS = -cp .:$(HOME)/lib/ac_library.jar
JAVATARGET = Main.class

ELIXIRC = elixirc
ELIXIRCFLAGS = -o .
ELIXIR = elixir
ELIXIRFLAGS = -pa . -e
ELIXIRTARGET = Elixir.Main.beam

RUBY = ruby

PYTHON = python

CC = g++
CFLAGS = -std=gnu++20
CPPTARGET = main

RUSTC = rustc # main.rs
RUSTFLAGS = -O
RUSTTARGET = main

NODE = node
NODEFLAGS =

ifeq ($(PROG),java)
# JAVA
SRC = Main.java
TARGET = $(JAVATARGET)
ifeq ($(STRICT_MODE),1)
# Strict mode: use wrapper script with dynamic stack sizing
RUN_TEST = sh $(HOME)/lib/java.sh 1024
else
# Simple mode: basic execution
RUN_TEST = $(JAVA) $(JAVAFLAGS) Main
endif
# Java (OpenJDK 23.0.1)
OJ_SFLAGS = -l 5005
else
ifeq ($(PROG),elixir)
# Elixir - Always use Mix release (same as Judge environment)
SRC = Main.ex
JUDGEDIR = /judge/main
TARGET = $(JUDGEDIR)/_build/prod/rel/main/bin/main
RUN_TEST = $(JUDGEDIR)/_build/prod/rel/main/bin/main eval Main.main
$(TARGET): $(SRC)
	@rm -f $(JUDGEDIR)/lib/main.ex $(JUDGEDIR)/lib/Main.ex
	@cp $(SRC) $(JUDGEDIR)/lib/Main.ex
	cd $(JUDGEDIR) && MIX_ENV=prod mix release --quiet --overwrite 2>/tmp/err-out.$$ || cat /tmp/err-out.$$ 1>&2
# Elixir (1.18.4 (OTP 28.0.2))
OJ_SFLAGS = -l 5085
else
ifeq ($(PROG),ruby)
# Ruby
SRC = Main.rb
TARGET =
RUN_TEST = sh -c "RUBY_THREAD_VM_STACK_SIZE=1073741824 $(RUBY) --jit $(SRC)"
# Ruby (3.4.5)
OJ_SFLAGS = -l 5018
else
ifeq ($(PROG),python)
# Python
SRC = Main.py
TARGET =
RUN_TEST = $(PYTHON) -X int_max_str_digits=0 $(SRC)
# Python (CPython 3.13.7)
# 5055 (CPython (3.13.7))
# 5078 (PyPy3 (3.10-v7.3.12))
OJ_SFLAGS = -l 5055
else
ifeq ($(PROG), c++)
# C++
SRC = Main.cpp
TARGET = $(CPPTARGET)

# Using base flags from CFLAGS (line 50): -std=gnu++20
CPPFLAGS = $(CFLAGS)
LDFLAGS =

# Strict mode: AtCoder judge environment settings
ifeq ($(STRICT_MODE),1)
# Optimization flags
CPPFLAGS += -O2 -Wall -Wextra
# constexpr limits
CPPFLAGS += -fconstexpr-depth=1024 -fconstexpr-loop-limit=524288 -fconstexpr-ops-limit=2097152
# Optimization techniques
CPPFLAGS += -flto=auto -march=native
# Parallel processing
CPPFLAGS += -pthread -fopenmp
# Note: Boost/GMP/GMPXX linking requires container image with these libraries
# LDFLAGS = -lboost_system -lboost_filesystem -lgmp -lgmpxx
endif

RUN_TEST = ./$(CPPTARGET)
$(TARGET): $(SRC)
	$(CC) $(CPPFLAGS) $(LDFLAGS) $^ -o $@
# C++ (GNU++20 (GCC 12.3.0))
OJ_SFLAGS = -l 5001
else
ifeq ($(PROG),javascript)
# JavaScript
SRC = Main.js
TARGET =
ifeq ($(STRICT_MODE),1)
# Strict mode: use wrapper script with dynamic stack sizing (KB)
RUN_TEST = sh $(HOME)/lib/node.sh 65536 $(SRC)
else
# Simple mode: basic execution
RUN_TEST = $(NODE) $(SRC) ONLINE_JUDGE ATCODER
endif
# JavaScript (Node.js 23.5.0)
OJ_SFLAGS = -l 5083
else
ifeq ($(PROG), rust)
# Rust
SRC = main.rs
TARGET = $(RUSTTARGET)
RUN_TEST = ./$(RUSTTARGET)
$(TARGET): $(SRC)
	$(RUSTC) $(RUSTFLAGS) $^ -o $@
# Rust (1.87.0) - NOT SUPPORTED
error:
	  $(error PROG:$(PROG) not supported)
endif
endif
endif
endif
endif
endif
endif

OJ = oj
OJ_TFLAGS = -c '$(RUN_TEST)' --ignore-spaces-and-newline
OJ_TFLAGS_FLOAT = -e 1e-6

TASK:=$$(basename $(CURDIR))
TASK_URL:=$$(cat ../contest.acc.json|jq -r ".tasks|map(select(.directory.path==\"$(TASK)\"))[]|.url")

.PHONY: all test dl t s open web o edit e clean distclean
.SUFFIXES: .java .class .cpp .o

.java.class:
	$(JAVAC) $(JAVACFLAGS) $<

.cpp.o:
	$(CC) $(CFLAGS) -o $@ -c $<

test: test/sample-1.in $(TARGET)
	@for i in test/*.in; do \
		echo  %%% TEST DATA %%%  $$i; \
		echo %% input: %%; \
		cat $$i; \
		echo %% output: %%; \
		($(RUN_TEST) < $$i); \
		echo %% expected: %%; \
		cat $$(echo $$i | sed -e s/in/out/) ; \
		echo ''; \
	done

test1: test/sample-1.in $(TARGET)
	@for i in test/sample-1.in; do \
		echo  %%% TEST DATA %%%  $$i; \
		echo %% input: %%; \
		cat $$i; \
		echo %% output: %%; \
		($(RUN_TEST) < $$i); \
		echo %% expected: %%; \
		cat $$(echo $$i | sed -e s/in/out/) ; \
		echo ''; \
	done
test2: test/sample-2.in $(TARGET)
	@for i in test/sample-2.in; do \
		echo  %%% TEST DATA %%%  $$i; \
		echo %% input: %%; \
		cat $$i; \
		echo %% output: %%; \
		($(RUN_TEST) < $$i); \
		echo %% expected: %%; \
		cat $$(echo $$i | sed -e s/in/out/) ; \
		echo ''; \
	done
test3: test/sample-3.in $(TARGET)
	@for i in test/sample-3.in; do \
		echo  %%% TEST DATA %%%  $$i; \
		echo %% input: %%; \
		cat $$i; \
		echo %% output: %%; \
		($(RUN_TEST) < $$i); \
		echo %% expected: %%; \
		cat $$(echo $$i | sed -e s/in/out/) ; \
		echo ''; \
	done
test4: test/sample-4.in $(TARGET)
	@for i in test/sample-4.in; do \
		echo  %%% TEST DATA %%%  $$i; \
		echo %% input: %%; \
		cat $$i; \
		echo %% output: %%; \
		($(RUN_TEST) < $$i); \
		echo %% expected: %%; \
		cat $$(echo $$i | sed -e s/in/out/) ; \
		echo ''; \
	done
test5: test/sample-5.in $(TARGET)
	@for i in test/sample-5.in; do \
		echo  %%% TEST DATA %%%  $$i; \
		echo %% input: %%; \
		cat $$i; \
		echo %% output: %%; \
		($(RUN_TEST) < $$i); \
		echo %% expected: %%; \
		cat $$(echo $$i | sed -e s/in/out/) ; \
		echo ''; \
	done
test/sample-1.in:
	$(OJ) dl $(TASK_URL)
test/sample-2.in:
	$(OJ) dl $(TASK_URL)
test/sample-3.in:
	$(OJ) dl $(TASK_URL)
test/sample-4.in:
	$(OJ) dl $(TASK_URL)
dl: test/sample-1.in

dla: .dla.done
# DROPBOX_TOKEN environment variable must be set
#  https://gahaha.xyz/category1/dropboxdevelopergetaccesstoken.html
.dla.done:
	@$(OJ) dl --system --dropbox-token "${DROPBOX_TOKEN}" $(TASK_URL) && touch "$@"
dropboxapi:
	@$(OPEN) https://www.dropbox.com/developers

t: $(TARGET) test/sample-1.in
	$(OJ) t $(OJ_TFLAGS)

tf: $(TARGET) test/sample-1.in
	$(OJ) t $(OJ_TFLAGS) $(OJ_TFLAGS_FLOAT)

s: $(TARGET)
	$(OJ) s $(TASK_URL) $(SRC) $(OJ_SFLAGS)

run: $(TARGET)
	$(RUN_TEST)

o: web
open: web
web:
	@$(OPEN) $(TASK_URL)

e: edit
edit:
	$(EDITOR) $(SRC)

clean:
	-$(RM) $(OBJ) $(TARGET)

distclean:
	-$(RM) $(JAVATARGET) $(ELIXIRTARGET) (CPPTARGET) $(OBJ) $(TARGET) *~
