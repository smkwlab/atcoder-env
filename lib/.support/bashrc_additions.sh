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

# Elixir Language Server (installed by ElixirLS extension)
ELIXIR_LANGUAGE_SERVER_HOME=""
for dir in ${HOME}/.vscode-server/extensions/jakebecker.elixir-ls-*/elixir-ls-release; do
    [ -d "$dir" ] && ELIXIR_LANGUAGE_SERVER_HOME="$dir"
done
[ -n "$ELIXIR_LANGUAGE_SERVER_HOME" ] && export PATH="${PATH}:${ELIXIR_LANGUAGE_SERVER_HOME}"

# Source AtCoder login check
if [ -f ~/.atcoder_login_check.sh ]; then
    . ~/.atcoder_login_check.sh
fi
