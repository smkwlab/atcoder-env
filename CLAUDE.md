# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## プロジェクト概要
AtCoderコンテスト参加用のDev Container環境。VS Codeで開くと自動的に環境が構築される。

## よく使うコマンド

### コンテストのセットアップ
```bash
# 新規コンテスト用ディレクトリ作成（contest/ディレクトリで実行）
am new abc123
# または
acc new abc123 --no-tests
```

### コードのテストと提出
```bash
# テスト実行（各問題のディレクトリで実行）
am t .java   # Java
am t .py     # Python
am t .cpp    # C++
am t .rb     # Ruby
am t .ex     # Elixir
am t .rs     # Rust

# 浮動小数点誤差を許容するテスト
am tf .java

# コード提出
am s .java   # 各言語の拡張子を指定

# 問題ページをブラウザで開く
am o
# または
am web
```

### ディレクトリ移動のショートカット
```bash
# コンテストディレクトリへ移動
abc 123      # abc123ディレクトリへ
abc 123 a    # abc123/a問題のディレクトリへ
arc 123      # arc123へ
ahc 123      # ahc123へ
```

## VS Codeタスク
以下のタスクが設定済み（`Cmd+Shift+T` または `Ctrl+Shift+T`で実行）：
- **AtCoder: setup NEW contest** - 新規コンテストセットアップ
- **AtCoder: TEST code** - 開いているファイルのテスト実行
- **AtCoder: TEST(float) code** - 浮動小数点誤差許容テスト
- **AtCoder: SUBMIT code** - 開いているファイルの提出
- **AtCoder: OPEN Task Page** - 問題ページを開く（`Cmd+Shift+B` または `Ctrl+Shift+B`）

## プロジェクト構造

### 主要ディレクトリ
- `/root/contest/` - コンテストの作業ディレクトリ
- `/root/.config/atcoder-cli-nodejs/` - acc設定とテンプレート（コンテナ内）
- `atcoder-cli-nodejs/` - acc設定とテンプレート（ホスト）
- `bin/` - ユーティリティスクリプト
  - `am` - AtCoderタスク実行用フロントエンド
  - `open-atcoder` - ブラウザで問題を開くスクリプト

### 各言語のビルド・実行設定
makefileで管理（`/root/lib/.support/makefile`へのシンボリックリンク）

#### 言語バージョンと実行方式
- **Java: OpenJDK 23.0.1 (language ID: 5005) - 常に/judgeディレクトリでコンパイル・実行（Judge環境と同じ）**
- Python: CPython 3.13.7 (language ID: 5055) - judge環境と同じオプションで実行
- C++: GCC 15.2.0 C++23 (language ID: 5001)
- Ruby: 3.4.5 (language ID: 5018) - judge環境と同じオプションで実行
- **Elixir: 1.18.4 (OTP 28.0.2) (language ID: 5085) - 常にMix releaseでビルド（Judge環境と同じ）**
- **JavaScript: Node.js 22.19.0 (language ID: 5083) - 常にjudge環境設定（64MBスタック）で実行**
- Rust: 1.87.0 (未対応)

**注意**:
- Java は `am t .java` でも `am ts .java` でも常に `/judge` ディレクトリ方式（Judge 環境と同じ）でビルド・実行されます。問題ディレクトリに `.class` ファイルが生成されないため、クリーンな開発環境を維持できます。
- Elixir は `am t .ex` でも `am ts .ex` でも常に Mix release（judge 環境と同じ方式）でビルドされます。ビルド時間が短いため、開発効率とjudge環境との完全一致を両立できます。
- JavaScript は `am t .js` で常に64MBスタックサイズ（judge 環境と同じ）で実行されます。デフォルトのNode.jsスタック（約1MB）と異なり、再帰処理でのスタックオーバーフローを防ぎます。

### テンプレート設定
`atcoder-cli-nodejs/config.json`の`default-template`で指定:
- デフォルト: java, python, cpp, ruby, elixir
- 各言語のテンプレートは`atcoder-cli-nodejs/[言語名]/`に配置

## 環境変数
- `CONTEST_DIR`: `/root/contest` - コンテスト作業ディレクトリ
- `HOME`: `/root` - ホームディレクトリ

## 開発環境
- Docker Imageは`ghcr.io/smkwlab/atcoder-container:latest`を使用
- acc (atcoder-cli), oj (online-judge-tools)がプリインストール済み
- VS Code拡張機能が自動インストール（Java, Python, Ruby, Elixir等の言語サポート）

## Dev Containerでの動作確認方法

Emacsやホスト環境からDev Container内でテストを実行する方法：

### コンテナ名の確認
```bash
docker ps --filter "name=atcoder-env" --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
```
通常、`atcoder-env_devcontainer-dev-1`という名前で実行中。

### テストコマンドの実行
**重要**: makefileはasdfの環境が必要なため、`bash -i`（対話的シェル）で実行すること。

```bash
# Java簡易モード
docker exec -i atcoder-env_devcontainer-dev-1 bash -i -c "cd /root/contest/abc123/a && make t PROG=java"

# Java厳密モード（wrapper script使用）
docker exec -i atcoder-env_devcontainer-dev-1 bash -i -c "cd /root/contest/abc123/a && STRICT_MODE=1 make t PROG=java"

# JavaScript簡易モード
docker exec -i atcoder-env_devcontainer-dev-1 bash -i -c "cd /root/contest/abc123/a && make t PROG=javascript"

# JavaScript厳密モード（wrapper script使用）
docker exec -i atcoder-env_devcontainer-dev-1 bash -i -c "cd /root/contest/abc123/a && STRICT_MODE=1 make t PROG=javascript"

# Python
docker exec -i atcoder-env_devcontainer-dev-1 bash -i -c "cd /root/contest/abc123/a && make t PROG=python"

# Ruby
docker exec -i atcoder-env_devcontainer-dev-1 bash -i -c "cd /root/contest/abc123/a && make t PROG=ruby"

# C++
docker exec -i atcoder-env_devcontainer-dev-1 bash -i -c "cd /root/contest/abc123/a && make t PROG=c++"
```

### 出力のフィルタリング
bash警告メッセージを除外して結果のみ表示：
```bash
docker exec -i atcoder-env_devcontainer-dev-1 bash -i -c "cd /root/contest/abc123/a && make t PROG=java 2>&1" | grep -v "bash:" | tail -20
```

### 手動テスト（`make test`）
`oj`がない環境や簡易テスト用：
```bash
docker exec -i atcoder-env_devcontainer-dev-1 bash -i -c "cd /root/contest/abc123/a && make test PROG=java"
```

### 注意事項
- makefileは`/bin/sh`を使用するが、asdfのshimは`.bashrc`で設定されるため、対話的シェル（`-i`）が必須
- 非対話的シェル（`bash -c`）ではasdfのPATHが設定されず、`java: not found`等のエラーになる
- VS Codeのターミナルからは通常通り`make t PROG=java`で実行可能（自動的にログインシェル）