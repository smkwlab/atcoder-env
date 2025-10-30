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

echo
echo '=========================================='
echo 'AtCoder 用コンテナの準備が完了しました。'
echo '=========================================='
echo

# Check if already logged in
# Note: Authentication is persisted in ~/.config/atcoder-cli-nodejs/ and ~/.local/share/online-judge-tools/
SESSION_CHECK=$(acc session 2>&1)
if echo "$SESSION_CHECK" | grep -q "logged in\|ログイン済み"; then
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
    echo
fi

# Add login reminder to .bashrc
echo 'add login reminder to .bashrc'
if ! grep -q 'ATCODER_LOGIN_CHECKED' ${HOME}/.bashrc; then
    cat >> ${HOME}/.bashrc << 'EOF'

# Check AtCoder login status (once per shell session)
if [ -z "$ATCODER_LOGIN_CHECKED" ]; then
    export ATCODER_LOGIN_CHECKED=1

    # Check actual login status
    SESSION_CHECK=$(acc session 2>&1)
    if ! echo "$SESSION_CHECK" | grep -q "logged in\|ログイン済み"; then
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
fi
