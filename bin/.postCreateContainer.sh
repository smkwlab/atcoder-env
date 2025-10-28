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
echo '【重要】AtCoder ログインについて'
echo
echo 'AtCoder の仕様変更により、acc と oj の自動ログインが'
echo 'できなくなっています。代わりに aclogin でログインしてください。'
echo
echo '■ Cookie の取得方法:'
echo '  1. ブラウザで https://atcoder.jp にログイン'
echo '  2. 開発者ツール（F12）を開く'
echo '  3. Application（Chrome）または Storage（Firefox）タブを選択'
echo '  4. Cookies から REVEL_SESSION の値をコピー'
echo
echo '詳細: https://qiita.com/namonaki/items/16cda635dd7c34496aaa'
echo
echo '以下でクッキーを入力してください（スキップする場合は Ctrl+C）:'
echo

if command -v aclogin >/dev/null 2>&1; then
    aclogin || echo 'aclogin をスキップしました。後で手動で実行できます: aclogin'
else
    echo 'エラー: aclogin コマンドが見つかりません。'
    echo '最新のコンテナイメージを使用してください。'
fi
