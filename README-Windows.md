# Windows 利用者への注意

Windows と Linux では標準の改行コードが異なる。
Linux が LF であるのに対して、Windows では CRLF である。

近年のエディタ類は改行コードを自動認識するので、この違いに気がつかないことも少なくない。
しかし、本環境においては shell script を含むため、この問題に明示的に対応する必要がある。

Windows 版 Git は、改行コードの自動変換機能がある。
本ドキュメントでは、この機能の説明は省略する。
この機能は true, false, input の3状態のいずれかを取る。
デフォルトの設定では true になっていることが多いようである。

本環境を利用する際には、この機能を input あるいは false にする必要がある。
本ドキュメントでは、これを input に変更する方法を説明する。


## 1. コマンドライン (Git Bash, PowerShell, コマンドプロンプト)

プロンプト上で `git config --global core.autocrlf input` を実行する。

現在の設定を確認するには同じく `git config --global -l` を実行する。


## 2. GitHub Desktop

以下のフォルダの中にある `gitconfig` を編集する。
なお、このフォルダは Explorer で`隠しファイル`を表示する設定にしておかないと見えない。また、`3.1.4`の部分は GitHub Desktop のバージョンによって異なる。利用する PC 上で確認すること。

```
C:\Users\[ユーザ名]\AppData\Local\GitHubDesktop\app-3.1.4\resources\app\git\etc
```

`gitconfig` 中の `autocrlf` の行を以下のように変更する。

```
autocrlf = input
```
