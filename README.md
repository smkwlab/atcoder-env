# AtCoder 参加用環境

このリポジトリをクローンし VSCode で開くと、devcontainer が環境を構築する。
docker image を大きくしたくなかったので、デフォルトでインストールするプログラミング言語処理系は絞っている。

なお、利用するプログラミング言語が Java, Python3, JavaScript のいずれかであれば、
[atcoder-java](https://github.com/smkwlab/atcoder-java)を利用するほうが手軽なのでお勧め。

AtCoder 用ツールの acc, oj はインストール済み。
後述の VSCode タスクを支援するための、独自ツールもインストール済み。

## 対応プログラミング言語

デフォルトのプログラミング言語は Java。
ただし、デフォルトで利用される docker image には Python3, JavaScript(nodejs)の処理系はインストール済み(acc, oj が必要とするから)。

docker image は、[atcoder-container](https://github.com/smkwlab/atcoder-container)で build したものを利用する。
イメージを作り直したい場合、そちらのリポジトリを参照。
そのうえで、[Dockerfile](.devcontainer/Dockerfile) の 1行目で、
自分で build したコンテナを利用するように変更する。

デフォルトで利用する docker image では、以下の言語に対応している。

- Java (JDK 17)
- Ruby (3.2.2)
- Elixir (1.15.2)
- Python3 (3.11.4)
- JavaScript (node.js 18.16.1)
- Erlang (26.0.2)

## 使い方

VSCode 上のターミナルで acc や oj を使って、そのまま利用することも可能。コンテスト用のディレクトリは ~/contest/ である。

お勧めの使い方は VSCode のタスク機能の利用。
以下のタスクが設定済み。

- 新規コンテスト参加 (acc new 相当)
- コードのテスト (oj t 相当)
- コードの提出 (acc submit 相当)
- 問題のページをブラウザで開く

これらのタスクを起動するために、`タスクの実行`をショートカットを設定しておくことがお勧め。
作者は mac では `Cmd + Shift + t`, Windows では `Ctrl + Shift + t` に割り当てている。
このキーは、`閉じたエディタを再度開く`機能に割り当てられているが、
AtCoder 参加中にこの機能を使うことは少ないと判断している。

### ショートカットキー設定方法

1. mac の場合、Cmd + k Cmd + s, Windows の場合 Ctrl + k Ctrl + s を押して `キーボードショートカット` 画面を表示させる
2. `キーボードショートカット`画面内の検索窓に`タスクの実行`を入力する
3. `タスク:タスクの実行`の左側の`+`を押して、`Cmd + Shift + t` あるいは `Ctrl + Shift + t` を入力後 `Enter` を入力

### 新規コンテストセットアップタスク

タスク名：`AtCoder: setup NEW contest` 

起動すると、プロンプトが表示されるので、そこで `abc101` などと入力すると、`acc new abc101 --no-tests` のようにコマンドを実行し各問題用ディレクトリを作成する。
テストケースは、後述のコードテスト用タスクで自動でダウンロードする。
このタスクは、~/contest/ ディレクトリ上で実行される。

### コードテスト用タスク

タスク名: `AtCoder: TEST code`

開いているソースコードを対象に `oj t` 相当のコマンドを実行する。
ソースコードの拡張子を元に必要な `-c` オプションを追加する。
テストケースは、このタスクの初回実行時に自動でダウンロードする。
テストケースを、セットアップ時にダウンロードしない理由は、提出タスクで余計なプロンプトを表示させないため。

### コード提出用タスク

タスク名: `AtCoder: SUBMIT code`

開いているソースコードを対象に `oj s` 相当のコマンドを実行する。
ソースコードの拡張子を元に、`-l` オプションを推測する。
間違うようであれば、各ディレクトリにある makefile 中の、該当する言語用の `OJ_SFLAGS` での `-l` 指定を変更。
makefile はシンボリックリンクになっているので、一度変更すると他のディレクトリ中の makefile もすべて変更される。


### 問題ページ閲覧用タスク

タスク名: `AtCoder: OPEN Task Page`

開いているソースコードの対象の問題のページをローカルのブラウザで開く。
このタスクのみ、コンテナ作成後一度だけ、以下の操作が必要。

1. VSCode で `ターミナル`→`新しいターミナル` を開く
2. そのプロンプト上で `open-atcoder` を実行
3. `Codeで外部の Web サイトを開きますか?` というダイアログが表示される
4. そのダイアログで `信頼されているドメインの構成` をクリック
5. `https://atcoder.jp を信頼する` を選択

このタスクをビルドタスクとして設定しているので、
ショートカット (`Ctrl + Shift + b` あるいは `Cmd + Shift + b`)で起動できる。
AtCoder では、ビルド処理を実行することは少ないと考えて、このような設定にしている。
テストや提出をビルド処理に割り当てたい場合には [tasks.json](.vscode/tasks.json) を変更する。

## コマンドライン

これらのタスクを実行するために、新規コンテストセットアップタスク以外では make を利用している。
VSCode 上のターミナルで、
該当する問題のディレクトリに移動後 make コマンドを実行することも可能。

新規コンテストセットアップタスクは acc を利用している。

タスク間の差異を吸収するために [am](bin/am) コマンドを用意している。

### 新規コンテストセットアップコマンド

`am new` コマンドを利用する。引数としてコンテスト名を与える。
例えば、`am new abc039` で abc039 用のセットアップができる。

### 問題用ディレクトリ移動

`abc` コマンドにより、指定した abc あるいは、さらにその問題のディレクトリに移動できる。
`arc` コマンド、`ahc` コマンドで、同様に arc, ahc の問題・ディレクトリに移動可能。

例えば `abc 039` で abc039 用のディレクトリに移動。
`abc 039 a` で abc039 の a問題のディレクトリに移動。

問題のディレクトリに移動したあとで、`code Main.java` のように 
code コマンドを使うことでファイルを編集できる。
VS Code のエクスプローラを使わずに、CLI で操作できる。

### 問題ページ閲覧用コマンド

各問題用のディレクトリに移動したあと、`am o` コマンドを実行すると、
そのディレクトリに対応した問題のページをブラウザで開く。

### コードテスト用コマンド

各問題用のディレクトリに移動したあと、`am t` コマンドに拡張子を引数として追加することで、その言語用のプログラム用のテストを走らせる。
例えば、`am t .java` のように実行する。
拡張子の先頭の `.` を付け忘れないこと。

### コード提出用コマンド

各問題用のディレクトリに移動したあと、`am s` コマンドに拡張子を引数として追加することで、その言語用のプログラム用を提出する。
例えば、`am s .java` のように実行する。
拡張子の先頭の `.` を付け忘れないこと。



## GitHub repository
https://github.com/smkwlab/docker-atcoder

この環境は、学生が AtCoder に参加する環境を構築するのを支援するために開発した。
元は https://github.com/hinamimi/docker-atcoder から fork して開発を開始した。
現在は差分が大きくなったので、独立したリポジトリとしている。

## カスタマイズ

### 新規コンテストセットアップ時

新規コンテストセットアップは acc の機能を利用している。
devcontainer 内ならば .config/atcoder-cli-nodejs/ 、
devcontainer 外ならば atcoder-cli-nodejs/
に設定ファイルが存在する。
このフォルダの config.json を編集することで挙動を変更できる。

例えば、デフォルトでコピーされるテンプレートファイルは java のものである。
これは config.json 中の default-template の値で変更できる。

また、各言語用のテンプレートファイルは、
このディレクトリ下の言語名のディレクトリ下にあるので、
これを好みに編集するのがお勧め。

### コード提出時言語選択

まず、プログラミング言語は、ファイルの拡張子で決定している。
`bin/am` スクリプト内で、判定している。
shell script で書かれているが、それほど複雑ではないので変更・追加は容易だと思う。
このスクリプト内で設定した変数 PROG は、次に説明する makefile 中で利用される。

各プログラミング言語のバージョンは各タスク用ディレクトリ内の makefile で決定される。
makefile は文法が若干特殊なので分かりにくいが、
基本的には `OJ_SFLAGS` という変数に適切な値を設定することで
`oj` コマンドでのコード提出時の言語指定を実現している。

なお、この makefile は UNIX のシンボリックリンクを用いて、
実態は一つになっている。
どこかのディレクトリ中の makefile を変更すると、すべての makefile が書き換わる。
