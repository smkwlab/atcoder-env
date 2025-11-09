# AtCoder environment additional configuration for .bashrc
# This file is sourced from ~/.bashrc

# Load bash functions
if [ -f "${HOME}/lib/.support/bash_functions.sh" ]; then
    . "${HOME}/lib/.support/bash_functions.sh"
fi

# Set contest directory
export CONTEST_DIR=/root/contest

# Add custom bin directory to PATH
export PATH="/root/bin:${PATH}"

# Add VS Code extension-installed LSP to PATH
# Java Language Server (installed by Red Hat Java extension)
JAVA_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/redhat.java-*/server/bin 2>/dev/null | sort -V | tail -n1)"
[ -n "$JAVA_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${JAVA_LANGUAGE_SERVER_HOME}"
unset JAVA_LANGUAGE_SERVER_HOME

# Python Language Server (installed by Microsoft Python extension)
PYTHON_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/ms-python.python-*/languageServer 2>/dev/null | sort -V | tail -n1)"
[ -n "$PYTHON_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${PYTHON_LANGUAGE_SERVER_HOME}"
unset PYTHON_LANGUAGE_SERVER_HOME

# C++ Language Server (installed by C/C++ extension or clangd)
CPP_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/llvm-vs-code-extensions.vscode-clangd-*/bin 2>/dev/null | sort -V | tail -n1)"
[ -n "$CPP_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${CPP_LANGUAGE_SERVER_HOME}"
unset CPP_LANGUAGE_SERVER_HOME

# Ruby Language Server (installed by Ruby LSP or Solargraph extension)
RUBY_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/shopify.ruby-lsp-*/bin 2>/dev/null | sort -V | tail -n1)"
if [ -z "$RUBY_LANGUAGE_SERVER_HOME" ]; then
    RUBY_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/castwide.solargraph-*/bin 2>/dev/null | sort -V | tail -n1)"
fi
[ -n "$RUBY_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${RUBY_LANGUAGE_SERVER_HOME}"
unset RUBY_LANGUAGE_SERVER_HOME

# Elixir Language Server (installed by ElixirLS extension)
ELIXIR_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/jakebecker.elixir-ls-*/elixir-ls-release 2>/dev/null | sort -V | tail -n1)"
[ -n "$ELIXIR_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${ELIXIR_LANGUAGE_SERVER_HOME}"
unset ELIXIR_LANGUAGE_SERVER_HOME

# Erlang Language Server (installed by Erlang extension)
ERLANG_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/pgourlain.erlang-*/erlang_ls/_build/default/bin 2>/dev/null | sort -V | tail -n1)"
[ -n "$ERLANG_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${ERLANG_LANGUAGE_SERVER_HOME}"
unset ERLANG_LANGUAGE_SERVER_HOME

# JavaScript/TypeScript Language Server (installed by built-in or extension)
JAVASCRIPT_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/ms-vscode.vscode-typescript-*/bin 2>/dev/null | sort -V | tail -n1)"
[ -n "$JAVASCRIPT_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${JAVASCRIPT_LANGUAGE_SERVER_HOME}"
unset JAVASCRIPT_LANGUAGE_SERVER_HOME

# Rust Language Server (installed by rust-analyzer extension)
RUST_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/rust-lang.rust-analyzer-*/server 2>/dev/null | sort -V | tail -n1)"
[ -n "$RUST_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${RUST_LANGUAGE_SERVER_HOME}"
unset RUST_LANGUAGE_SERVER_HOME

# PHP Language Server (installed by PHP Intelephense or other extension)
PHP_LANGUAGE_SERVER_HOME="$(ls -1d ${HOME}/.vscode-server/extensions/bmewburn.vscode-intelephense-client-*/node_modules/.bin 2>/dev/null | sort -V | tail -n1)"
[ -n "$PHP_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${PHP_LANGUAGE_SERVER_HOME}"
unset PHP_LANGUAGE_SERVER_HOME

# Source AtCoder login check
if [ -f ~/.atcoder_login_check.sh ]; then
    . ~/.atcoder_login_check.sh
fi
