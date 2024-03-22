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
JAVACFLAGS = -J-Dfile.encoding=UTF-8 -Xlint:unchecked
JAVA = java
JAVATARGET = Main.class

ELIXIRC = elixirc
ELIXIRCFLAGS = -o .
ELIXIR = elixir
ELIXIRFLAGS = -pa . -e
ELIXIRTARGET = Elixir.Main.beam

RUBY = ruby

PYTHON = python

CC = g++
CFLAGS = -std=c++14
CPPTARGET = main

ifeq ($(PROG),java)
# JAVA
SRC = Main.java
TARGET = $(JAVATARGET)
RUN_TEST = $(JAVA) Main
# 5005 (Java (OpenJDK 17))
OJ_SFLAGS = -l 5005
else
ifeq ($(PROG),elixir)
# Elixir
SRC = Main.ex
TARGET = $(ELIXIRTARGET)
RUN_TEST = $(ELIXIR) $(ELIXIRFLAGS) Main.main
$(TARGET) : $(SRC)
	$(ELIXIRC) $(SRC) $(ELIXIRCFLAGS)
# 5085 (Elixir (1.15.2))
OJ_SFLAGS = -l 5085
else
ifeq ($(PROG),ruby)
# Ruby
SRC = Main.rb
TARGET =
RUN_TEST = $(RUBY) $(SRC)
# 5018 (Ruby (3.2.2))
OJ_SFLAGS = -l 5018
else
ifeq ($(PROG),python)
# Python
SRC = Main.py
TARGET =
RUN_TEST = $(PYTHON) $(SRC)
# 5055 (CPython (3.11.4))
# 5078 (PyPy3 (3.10-v7.3.12))
OJ_SFLAGS = -l 5055
else
ifeq ($(PROG), c++)
# C++
SRC = Main.cpp
TARGET = $(CPPTARGET)
RUN_TEST = ./$(CPPTARGET)
$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $^ -o $@
# 5001 (C++ 20 (gcc 12.2))
OJ_SFLAGS = -l 5001
else
# NOT SUPPORTED
error:
	  $(error PROG:$(PROG) not supported)
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
		cat $$i | $(RUN_TEST); \
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
		cat $$i | $(RUN_TEST); \
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
		cat $$i | $(RUN_TEST); \
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
		cat $$i | $(RUN_TEST); \
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
		cat $$i | $(RUN_TEST); \
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
