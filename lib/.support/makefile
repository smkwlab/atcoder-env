#
# Makefile for AtCoder
#

# select default programming language
PROG ?= java
#PROG ?= elixir
#PROG ?= ruby
#PROG ?= python

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
ifeq ($(findstring microsoft,$(OS_REL)),microsoft)
# WSL
OPEN = powershell.exe /c start 
else
# Linux
OPEN = xdg-open
endif
endif
endif

JAVAC = javac
JAVACFLAGS = -J-Dfile.encoding=UTF-8 -Xlint:unchecked
JAVA = java

ELIXIRC = elixirc
ELIXIRCFLAGS = -o .
ELIXIR = elixir
ELIXIRFLAGS = -pa . -e

RUBY = ruby

PYTHON = python

ifeq ($(PROG),java)
# JAVA
SRC = Main.java
OBJ = Main.class
RUN_TEST = $(JAVA) Main
# 4005 (Java (OpenJDK 11.0.6))
# 4052 (Java (OpenJDK 1.8.0))
OJ_SFLAGS = -l 4005
else
  ifeq ($(PROG),elixir)
# Elixir
SRC = Main.ex
OBJ = Elixir.Main.beam
RUN_TEST = $(ELIXIR) $(ELIXIRFLAGS) Main.main
$(OBJ) : $(SRC)
	$(ELIXIRC) $(SRC) $(ELIXIRCFLAGS)
# 4021 (Elixir (1.10.2))
OJ_SFLAGS = -l 4021
  else
# Ruby
    ifeq ($(PROG),ruby)
SRC = Main.rb
OBJ =
RUN_TEST = $(RUBY) $(SRC)
# 4049 (Ruby (2.7.1))
OJ_SFLAGS = -l 4049
    else
      ifeq ($(PROG),python)
# Python
SRC = Main.py
OBJ = 
RUN_TEST = $(PYTHON) $(SRC)
# 4006 (Python (3.8.2))
# 4046 (PyPy2 (7.3.0))
# 4047 (PyPy3 (7.3.0))
OJ_SFLAGS = -l 4006
      else
# NOT SUPPORTED
error:
	$(error PROG:$(PROG) not supported)
      endif
    endif
  endif
endif

OJ = oj
OJ_T_EXTRA_FILE = tflags.txt
ifneq ("$(wildcard $(OJ_T_EXTRA_FILE))", "")
OJ_TFLAGS_EXTRA = $$(cat $(OJ_T_EXTRA_FILE))
endif
OJ_TFLAGS = -c '$(RUN_TEST)' --ignore-spaces-and-newline $(OJ_TFLAGS_EXTRA)

TASK:=$$(basename $(CURDIR))
TASK_URL:=$$(cat ../contest.acc.json|jq -r ".tasks|map(select(.directory.path==\"$(TASK)\"))[]|.url")

.PHONY: all test dl t s open web o edit e clean distclean
.SUFFIXES: .java .class
.java.class:
	$(JAVAC) $(JAVACFLAGS) $<

all: t

test: test/sample-1.in $(OBJ) 
	@for i in test/*.in; do \
		echo  %%% TEST DATA %%%  $$i; \
		echo %% input: %%; \
		cat $$i; \
		echo %% output: %%; \
		cat $$i | $(RUN_TEST); \
		echo %% expected: %%; \
		cat $$(i//in/out); \
		echo ''; \
	done

test/sample-1.in:
	$(OJ) dl $(TASK_URL)
dl: test/sample-1.in

dla: .dla.done
# DROPBOX_TOKEN environment variable must be set
#  https://gahaha.xyz/category1/dropboxdevelopergetaccesstoken.html
.dla.done:
	@$(OJ) dl --system --dropbox-token "${DROPBOX_TOKEN}" $(TASK_URL) && touch "$@"
dropboxapi:
	@$(OPEN) https://www.dropbox.com/developers

t: $(OBJ) test/sample-1.in
	$(OJ) t $(OJ_TFLAGS)

s: $(OBJ)
	$(OJ) s $(TASK_URL) $(SRC) $(OJ_SFLAGS)

run: $(OBJ)
	$(RUN_TEST)

o: web
open: web
web:
	@$(OPEN) $(TASK_URL)

e: edit
edit:
	$(EDITOR) $(SRC)

clean:
	-$(RM) $(OBJ)

distclean:
	-$(RM) *.class Elixir.Main.beam $(OBJ) *~
