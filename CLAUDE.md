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

#### 言語バージョン
- Java: OpenJDK 23.0.1 (language ID: 5005)
- Python: CPython 3.13.7 (language ID: 5055)
- C++: GCC 15.2.0 C++23 (language ID: 5001)
- Ruby: 3.4.5 (language ID: 5018)
- Elixir: 1.18.4 (OTP 28.0.2) (language ID: 5085)
- JavaScript: Node.js 22.19.0
- Rust: 1.87.0 (未対応)

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