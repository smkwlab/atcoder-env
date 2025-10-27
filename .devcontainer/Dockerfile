FROM ghcr.io/smkwlab/atcoder-container:202510update-lite

ARG HOME=/root

# Install additional tools not included in lite version
RUN apt-get update && apt-get install -y --no-install-recommends \
    jq \
    && rm -rf /var/lib/apt/lists/*

RUN echo ". ${HOME}/lib/.support/bash_functions.sh" >> ${HOME}/.bashrc
ENV CONTEST_DIR $HOME/contest
ENV PATH="${HOME}/bin:${PATH}"
