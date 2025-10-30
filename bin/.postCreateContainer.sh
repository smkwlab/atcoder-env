#! /bin/bash

echo 'setup environment variables in .bashrc'
if ! grep -q 'bash_functions.sh' ${HOME}/.bashrc; then
  echo '. ${HOME}/lib/.support/bash_functions.sh' >> ${HOME}/.bashrc
fi
if ! grep -q 'CONTEST_DIR' ${HOME}/.bashrc; then
  echo 'export CONTEST_DIR=/root/contest' >> ${HOME}/.bashrc
fi
if ! grep -q '/root/bin' ${HOME}/.bashrc; then
  echo 'export PATH="/root/bin:${PATH}"' >> ${HOME}/.bashrc
fi

echo 'create symlinks for makefile'
cd ${HOME}/.config/atcoder-cli-nodejs
progs=$(find . ! -name . -type d -print | sed -e 's,\./,,')
for i in ${progs}; do
  (cd ${i}; ln -sf ${HOME}/lib/.support/makefile)
done

# Remove Elixir template main.ex to avoid module conflict
rm -f /judge/main/lib/main.ex

echo
echo '=========================================='
echo 'AtCoder 用コンテナの準備が完了しました。'
echo '=========================================='
echo

# Check if already logged in
# Note: Authentication is persisted in ~/.config/atcoder-cli-nodejs/ and ~/.local/share/online-judge-tools/
# acc session outputs "OK" when logged in (confirmed from source code)
SESSION_CHECK=$(acc session 2>&1)
if echo "$SESSION_CHECK" | grep -q "OK"; then
    echo '✓ AtCoder に既にログイン済みです。'
    echo
elif echo "$SESSION_CHECK" | grep -q "network\|timeout\|接続\|failed to connect"; then
    echo '⚠ 警告: ネットワークエラーによりログイン状態を確認できません。'
    echo '後で手動で確認してください: acc session'
    echo
else
    echo '【注意】AtCoder ログインが必要です'
    echo
    echo 'AtCoder の仕様変更により手動ログインが必要です。'
    echo

    # Check if running in VS Code Dev Container, Codespaces, or interactive terminal
    if [ -n "$REMOTE_CONTAINERS" ] || [ -n "$CODESPACES" ] || [ -n "$VSCODE_IPC_HOOK_CLI" ] || [ -t 0 ]; then
        # VS Code Dev Container, Codespaces, or interactive environment - prompt for login
        echo 'Cookie の取得方法:'
        echo '  1. ブラウザで https://atcoder.jp にログイン'
        echo '  2. 開発者ツール（F12）→ Application → Cookies'
        echo '  3. REVEL_SESSION の値をコピー'
        echo
        echo '詳細: https://qiita.com/namonaki/items/16cda635dd7c34496aaa'
        echo
        echo 'クッキーを入力してください（Ctrl+C でスキップ）:'
        echo

        if command -v aclogin >/dev/null 2>&1; then
            aclogin || true
        else
            echo 'エラー: aclogin コマンドが見つかりません。'
            echo '最新のコンテナイメージを使用してください。'
        fi
    else
        # Pure non-interactive environment (CI, etc.)
        echo 'コンテナ作成後、ターミナルで以下を実行してください:'
        echo '  aclogin'
        echo
        echo 'Cookie の取得方法:'
        echo '  1. ブラウザで https://atcoder.jp にログイン'
        echo '  2. 開発者ツール（F12）→ Application → Cookies'
        echo '  3. REVEL_SESSION の値をコピー'
        echo
        echo '詳細: https://qiita.com/namonaki/items/16cda635dd7c34496aaa'
    fi
    echo
fi

# Setup login reminder
echo 'setup login reminder'

# Remove old inline versions from .bashrc if they exist
if grep -q 'ATCODER_LOGIN_CHECK' ${HOME}/.bashrc; then
    # Create backup
    cp ${HOME}/.bashrc ${HOME}/.bashrc.backup
    # Remove all old inline versions
    sed -i '/# BEGIN_ATCODER_LOGIN_CHECK/,/# END_ATCODER_LOGIN_CHECK/d' ${HOME}/.bashrc
    sed -i '/# Check AtCoder login status (once per shell session)/,/^fi$/d' ${HOME}/.bashrc
fi

# Create separate login check script (overwrite every time for updates)
cat > ${HOME}/.atcoder_login_check.sh << 'EOF'
# AtCoder login status check (v2)
if [ -z "$ATCODER_LOGIN_CHECKED" ]; then
    export ATCODER_LOGIN_CHECKED=1

    # Check actual login status
    # acc session outputs "OK" when logged in, "not login" when not logged in
    SESSION_CHECK=$(acc session 2>&1)
    if ! echo "$SESSION_CHECK" | grep -q "OK"; then
        # Only show warning if not a network error
        if ! echo "$SESSION_CHECK" | grep -q "network\|timeout\|接続\|failed to connect"; then
            echo ""
            echo "⚠️  AtCoder ログインが必要です"
            echo "    ログイン方法: aclogin"
            echo "    詳細: https://qiita.com/namonaki/items/16cda635dd7c34496aaa"
            echo ""
        fi
    fi
fi
EOF

# Add source line to .bashrc (only once)
if ! grep -q '.atcoder_login_check.sh' ${HOME}/.bashrc; then
    cat >> ${HOME}/.bashrc << 'EOF'

# Source AtCoder login check
if [ -f ~/.atcoder_login_check.sh ]; then
    . ~/.atcoder_login_check.sh
fi
EOF
fi
