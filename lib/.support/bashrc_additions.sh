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
JAVA_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/redhat.java-*/server/bin; do
    [ -d "$dir" ] && JAVA_LANGUAGE_SERVER_HOME="$dir"
done
[ -n "$JAVA_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${JAVA_LANGUAGE_SERVER_HOME}"

# Python Language Server (installed by Microsoft Python extension)
PYTHON_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/ms-python.python-*/languageServer; do
    [ -d "$dir" ] && PYTHON_LANGUAGE_SERVER_HOME="$dir"
done
[ -n "$PYTHON_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${PYTHON_LANGUAGE_SERVER_HOME}"

# C++ Language Server (installed by C/C++ extension or clangd)
CPP_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/llvm-vs-code-extensions.vscode-clangd-*/bin; do
    [ -d "$dir" ] && CPP_LANGUAGE_SERVER_HOME="$dir"
done
[ -n "$CPP_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${CPP_LANGUAGE_SERVER_HOME}"

# Ruby Language Server (installed by Ruby LSP or Solargraph extension)
RUBY_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/shopify.ruby-lsp-*/bin; do
    [ -d "$dir" ] && RUBY_LANGUAGE_SERVER_HOME="$dir"
done
if [ -z "$RUBY_LANGUAGE_SERVER_HOME" ]; then
    for dir in ${HOME}/.vscode-server/extensions/castwide.solargraph-*/bin; do
        [ -d "$dir" ] && RUBY_LANGUAGE_SERVER_HOME="$dir"
    done
fi
[ -n "$RUBY_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${RUBY_LANGUAGE_SERVER_HOME}"

# Elixir Language Server (installed by ElixirLS extension)
ELIXIR_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/jakebecker.elixir-ls-*/elixir-ls-release; do
    [ -d "$dir" ] && ELIXIR_LANGUAGE_SERVER_HOME="$dir"
done
[ -n "$ELIXIR_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${ELIXIR_LANGUAGE_SERVER_HOME}"

# Erlang Language Server (installed by Erlang extension)
ERLANG_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/pgourlain.erlang-*/erlang_ls/_build/default/bin; do
    [ -d "$dir" ] && ERLANG_LANGUAGE_SERVER_HOME="$dir"
done
[ -n "$ERLANG_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${ERLANG_LANGUAGE_SERVER_HOME}"

# JavaScript/TypeScript Language Server (installed by built-in or extension)
JAVASCRIPT_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/ms-vscode.vscode-typescript-*/bin; do
    [ -d "$dir" ] && JAVASCRIPT_LANGUAGE_SERVER_HOME="$dir"
done
[ -n "$JAVASCRIPT_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${JAVASCRIPT_LANGUAGE_SERVER_HOME}"

# Rust Language Server (installed by rust-analyzer extension)
RUST_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/rust-lang.rust-analyzer-*/server; do
    [ -d "$dir" ] && RUST_LANGUAGE_SERVER_HOME="$dir"
done
[ -n "$RUST_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${RUST_LANGUAGE_SERVER_HOME}"

# PHP Language Server (installed by PHP Intelephense or other extension)
PHP_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/bmewburn.vscode-intelephense-client-*/node_modules/.bin; do
    [ -d "$dir" ] && PHP_LANGUAGE_SERVER_HOME="$dir"
done
[ -n "$PHP_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${PHP_LANGUAGE_SERVER_HOME}"

# Source AtCoder login check
if [ -f ~/.atcoder_login_check.sh ]; then
    . ~/.atcoder_login_check.sh
fi
