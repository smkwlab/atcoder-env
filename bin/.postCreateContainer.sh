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

echo 'login for acc'
acc login
echo 'login for oj'
oj login https://atcoder.jp

echo
echo 'AtCoder 用コンテナの準備が完了しました。'
echo
