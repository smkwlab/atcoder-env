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

# Judge Directory
JUDGEDIR ?= /judge

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

RUBY = ruby

PYTHON = python3

# Common build rule template for compiled languages
# Usage: Set BUILD_SRC_PATH and COMPILE_CMD, then $(eval $(COMPILE_RULE))
define COMPILE_RULE
.PHONY: $(TARGET)
$(TARGET): $(SRC)
	@rm -f $(BUILD_SRC_PATH) $(TARGET)
	cp $(SRC) $(BUILD_SRC_PATH)
	$(COMPILE_CMD)
endef

# Language configurations
ifeq ($(PROG),java)
SRC = Main.java
TARGET = $(JUDGEDIR)/Main.class
BUILD_SRC_PATH = $(JUDGEDIR)/$(SRC)
COMPILE_CMD = javac -J-Dfile.encoding=UTF-8 -Xlint:unchecked -cp $(JUDGEDIR)/ac_library.jar $(JUDGEDIR)/$(SRC)
RUN_TEST = sh /judge/java.sh 1024 $(JUDGEDIR)
OJ_SFLAGS = -l 5005
# Java (OpenJDK 23.0.1)
$(eval $(COMPILE_RULE))

else ifeq ($(PROG),c++)
SRC = Main.cpp
TARGET = $(JUDGEDIR)/a.out
BUILD_SRC_PATH = $(JUDGEDIR)/$(SRC)
COMPILE_CMD = cd $(JUDGEDIR) && /judge/cpp.sh
RUN_TEST = $(JUDGEDIR)/a.out
OJ_SFLAGS = -l 5001
# C++ (GNU++23 (GCC 15.2.0))
$(eval $(COMPILE_RULE))

else ifeq ($(PROG),erlang)
SRC = Main.erl
TARGET = $(JUDGEDIR)/Main.beam
BUILD_SRC_PATH = $(JUDGEDIR)/$(SRC)
COMPILE_CMD = cd $(JUDGEDIR) && erlc $(SRC)
RUN_TEST = sh -c "cd $(JUDGEDIR) && erl -noshell -run Main main run"
OJ_SFLAGS = -l 5028
# Erlang (28.0.2)
# Language ID is not yet confirmed (TBD)
$(eval $(COMPILE_RULE))

else ifeq ($(PROG),rust)
SRC = main.rs
TARGET = $(JUDGEDIR)/target/release/main
BUILD_SRC_PATH = $(JUDGEDIR)/src/$(SRC)
COMPILE_CMD = cd $(JUDGEDIR) && RUST_BACKTRACE=0 cargo build --release --quiet
RUN_TEST = $(JUDGEDIR)/target/release/main
OJ_SFLAGS = -l 5087
# Rust (1.87.0)
$(eval $(COMPILE_RULE))

else ifeq ($(PROG),elixir)
SRC = Main.ex
ELIXIR_WORKDIR = $(JUDGEDIR)/main
TARGET = $(ELIXIR_WORKDIR)/_build/prod/rel/main/bin/main
BUILD_SRC_PATH = $(ELIXIR_WORKDIR)/lib/$(SRC)
COMPILE_CMD = cd $(ELIXIR_WORKDIR) && MIX_ENV=prod mix release --quiet --overwrite
RUN_TEST = $(TARGET) eval Main.main
OJ_SFLAGS = -l 5085
# Elixir (1.18.4 (OTP 28.0.2))
$(eval $(COMPILE_RULE))

else ifeq ($(PROG),ruby)
SRC = Main.rb
TARGET =
RUN_TEST = sh -c "RUBY_THREAD_VM_STACK_SIZE=1073741824 $(RUBY) --jit $(SRC)"
OJ_SFLAGS = -l 5018
# Ruby (3.4.5)

else ifeq ($(PROG),python)
SRC = Main.py
TARGET =
RUN_TEST = $(PYTHON) -X int_max_str_digits=0 $(SRC)
OJ_SFLAGS = -l 5055
# Python (CPython 3.13.7)
# 5055 (CPython (3.13.7))
# 5078 (PyPy3 (3.10-v7.3.12))

else ifeq ($(PROG),javascript)
SRC = Main.js
TARGET =
RUN_TEST = sh /judge/node.sh 65536 $(SRC)
OJ_SFLAGS = -l 5083
# JavaScript (Node.js 22.19.0)

else ifeq ($(PROG),php)
SRC = Main.php
TARGET =
RUN_TEST = php $(SRC)
OJ_SFLAGS = -l 5084
# PHP (8.4.12)
# Language ID is not yet confirmed (TBD)

endif

OJ = oj
OJ_TFLAGS = -c '$(RUN_TEST)' --ignore-spaces-and-newline
OJ_TFLAGS_FLOAT = -e 1e-6

TASK:=$$(basename $(CURDIR))
TASK_URL:=$$(cat ../contest.acc.json|jq -r ".tasks|map(select(.directory.path==\"$(TASK)\"))[]|.url")

.PHONY: all test dl t s open web o edit e clean

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
	-$(RM) $(TARGET)
