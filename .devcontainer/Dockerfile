FROM ubuntu:22.04

# コンテナ構築用にホームディレクトリ代入
ARG HOME=/root

ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NONINTERACTIVE_SEEN=true
ENV TZ=Asia/Tokyo \
    PATH=$HOME/bin:$PATH

# base system
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
            curl \
            git \
            ca-certificates \
            locales \
            time \
            tzdata \
            xdg-utils \
            g++-12 \
            build-essential \
            && \
    localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"

# asdf 
SHELL ["/bin/bash", "-lc"]
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.2 && \
    echo ". ${HOME}/.asdf/asdf.sh" >> ${HOME}/.bashrc && \
    echo ". ${HOME}/.asdf/completions/asdf.bash" >> ${HOME}/.bashrc

# Python, oj
RUN . ${HOME}/.asdf/asdf.sh && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
            jq \
            libbz2-dev libffi-dev libgdbm-dev libgdbm-compat-dev liblzma-dev \
            libncurses5-dev libreadline6-dev libsqlite3-dev libssl-dev \
            lzma lzma-dev tk-dev uuid-dev zlib1g-dev \
            && \
    asdf plugin-add python https://github.com/danhper/asdf-python.git && \
    asdf install python 3.11.4 && \
    asdf global python 3.11.4 && \
    pip install online-judge-tools==11.5.1 && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
# nodejs, atcoder-cli
RUN . ${HOME}/.asdf/asdf.sh && \
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git && \
    asdf install nodejs 18.16.1 && \
    asdf global nodejs 18.16.1 && \
    npm install -g atcoder-cli@2.2.0


# AtCoder 参加用プログラミング言語
# C++
RUN apt-get update && \
    apt-get install -y --no-install-recommends libgmp3-dev unzip && \
    cd /tmp && \
    # ac library
    mkdir -p /opt/ac-library && \
    curl -OL https://github.com/atcoder/ac-library/releases/download/v1.5.1/ac-library.zip && \
    unzip /tmp/ac-library.zip -d /opt/ac-library && \
    # boost
    curl -OL https://boostorg.jfrog.io/artifactory/main/release/1.82.0/source/boost_1_82_0.tar.gz && \
    tar xf boost_1_82_0.tar.gz && \
    cd boost_1_82_0 && \
    ./bootstrap.sh --with-toolset=gcc --without-libraries=mpi,graph_parallel && \
    ./b2 -j3 toolset=gcc variant=release link=static runtime-link=static cxxflags="-std=c++20" stage && \
    ./b2 -j3 toolset=gcc variant=release link=static runtime-link=static cxxflags="-std=c++20" --prefix=/opt/boost/gcc install && \
    #Eigen
    apt install -y libeigen3-dev=3.4.0-2ubuntu2 && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Java
RUN . ${HOME}/.asdf/asdf.sh && \
    asdf plugin-add java https://github.com/halcyon/asdf-java.git && \
    asdf install java adoptopenjdk-17.0.8+7 && \
    asdf global java adoptopenjdk-17.0.8+7

# # Ruby
RUN . ${HOME}/.asdf/asdf.sh && \
    apt-get update && \
    apt-get install -y --no-install-recommends libyaml-dev && \
    asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git && \
    asdf install ruby 3.2.2 && \
    asdf global ruby 3.2.2 && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    gem install rbtree && \
    gem install ac-library-rb && \
    gem install faster_prime && \
    gem install sorted_set && \
    gem install numo-narray && \
    gem install polars-df

# # erlang
RUN . ${HOME}/.asdf/asdf.sh && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
            libncurses5-dev libwxgtk3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev \
            libpng-dev libssh-dev \
            unixodbc-dev xsltproc fop libxml2-utils libncurses-dev \
            openjdk-11-jdk libwxgtk-webview3.0-gtk3-dev \
            erlang-dev erlang-xmerl erlang-parsetools erlang-os-mon inotify-tools && \
    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \
    asdf install erlang 26.0.2 && \
    asdf global erlang 26.0.2 && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# # elixir
RUN . ${HOME}/.asdf/asdf.sh && \
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \
    asdf install elixir 1.15.2 && \
    asdf global elixir 1.15.2 && \
    mix local.hex --force && \
    mix local.rebar --force

# Python
RUN . ${HOME}/.asdf/asdf.sh && \
    apt-get update && \
    apt-get install -y \
             libgmp-dev libmpfr-dev libmpc-dev && \
    python3.11 -m pip install \
               numpy==1.24.1 \
               scipy==1.10.1 \
               networkx==3.0 \
               sympy==1.11.1 \
               sortedcontainers==2.4.0 \
               more-itertools==9.0.0 \
               shapely==2.0.0 \
               bitarray==2.6.2 \
               PuLP==2.7.0 \
               mpmath==1.2.1 \
               pandas==1.5.2 \
               z3-solver==4.12.1.0 \
               scikit-learn==1.2.0 \
               ortools==9.5.2237 \
               torch \
               polars==0.15.15 \
               lightgbm==3.3.1 \
               gmpy2==2.1.5 \
               numba==0.57.0 \
               git+https://github.com/not522/ac-library-python && \
    python3.11 -m pip install -U setuptools==66.0.0 && \
    python3.11 -m pip install cppyy==2.4.1 && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

## C++でAtCoder Library(ACL)を使えるようにする
#RUN git clone https://github.com/atcoder/ac-library.git /lib/ac-library
#ENV CPLUS_INCLUDE_PATH /lib/ac-library

## # AHC用のRustのinstall
#RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
#ENV PATH $PATH:/home/root/.cargo/bin

ENV CONTEST_DIR $HOME/contest
WORKDIR $CONTEST_DIR
WORKDIR $HOME/lib
