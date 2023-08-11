FROM ubuntu:20.04

# コンテナ構築用にホームディレクトリ代入
ARG HOME=/root

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Tokyo \
    PATH=$HOME/bin:$PATH

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            curl \
            git \
            jq \
            locales \
            make \
            nodejs \
            npm \
            python3.8 \
            python3-pip \
            time \
            tzdata \
            && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"
RUN pip3 install online-judge-tools==11.5.1
RUN npm install -g atcoder-cli@2.2.0

# AtCoder 参加用プログラミング言語をインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
#            gcc-9 g++-9 \
#            openjdk-8-jdk-headless \
            openjdk-11-jdk-headless \
#            pypy3 \
#            ruby \
# elixir 使うなら erlang は必須            
#            erlang \
            && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# elixir
#RUN ELIXIR_VERSION="v1.10.2" && \
#    ELIXIR_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" && \
#    ELIXIR_DIR="/usr/local/src/elixir" && \
#    ELIXIR_TGZ="elixir-src.tar.gz" && \
#    curl -fSL -o ${ELIXIR_TGZ} ${ELIXIR_URL} && \
#    mkdir -p ${ELIXIR_DIR} && \
#    tar -xzC ${ELIXIR_DIR} --strip-components=1 -f ${ELIXIR_TGZ} && \
#    rm ${ELIXIR_TGZ} && \
#    cd ${ELIXIR_DIR} && \
#    make install clean && \
#    find ${ELIXIR_DIR}/ -type f -not -regex "${ELIXIR_DIR}/lib/[^\/]*/lib.*" -exec rm -rf {} + && \
#    find ${ELIXIR_DIR}/ -type d -depth -empty -delete
#

# バージョン番号非依存のコマンド名を設定
# e.g. python3.8 main.py => python main.py
RUN \
#    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 30 && \
#    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 30 && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.8 30 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 30 && \
#    update-alternatives --install /usr/bin/pypy pypy /usr/bin/pypy3 30 && \
    update-alternatives --install /usr/bin/node node /usr/bin/nodejs 30

## AtCoderでも使えるPythonライブラリをインストール
#RUN pip install numpy==1.18.2 && \
#    pip install scipy==1.4.1 && \
#    pip install scikit-learn==0.22.2.post1 && \
#    pip install numba==0.48.0 && \
#    pip install networkx==2.4

## Pythonでの競技プログラミング用データ構造をインストール
#RUN pip install git+https://github.com/hinamimi/ac-library-python && \
#    pip install git+https://github.com/hinamimi/python-sortedcontainers

## C++でAtCoder Library(ACL)を使えるようにする
#RUN git clone https://github.com/atcoder/ac-library.git /lib/ac-library
#ENV CPLUS_INCLUDE_PATH /lib/ac-library

## # AHC用のRustのinstall
#RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
#ENV PATH $PATH:/home/root/.cargo/bin

ENV CONTEST_DIR $HOME/contest
WORKDIR $CONTEST_DIR
WORKDIR $HOME/lib
