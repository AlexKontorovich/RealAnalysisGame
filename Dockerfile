# docker build . -t real-analysis-game
FROM node:20 AS builder

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

USER node

WORKDIR /home/node

COPY --chown=node:node . RealAnalysisGame

RUN git clone --depth 1 --branch main https://github.com/leanprover-community/lean4game.git

ENV ELAN_HOME=/usr/local/elan \
    PATH=/usr/local/elan/bin:$PATH

USER root


RUN export LEAN_VERSION="$(cat RealAnalysisGame/lean-toolchain | grep -oE '[^:]+$' | sed 's/-rc[0-9]*$//')" && \
    cat /etc/resolv.conf && \
    curl --retry 3 --retry-delay 2 https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y --no-modify-path --default-toolchain $LEAN_VERSION && \
    chmod -R a+w $ELAN_HOME && \
    elan --version && \
    elan toolchain install $LEAN_VERSION && \
    elan default $LEAN_VERSION && \
    lean --version && \
    leanc --version && \
    lake --version;

# pnpm just doesn't work
RUN cd RealAnalysisGame && lake update -R
RUN cd RealAnalysisGame && lake exe cache get && lake build --log-level error
RUN cd /home/node/lean4game && npm i && \
    cd /home/node/lean4game && npm run build && \
    npm cache clean --force && rm -rf ~/.cache

EXPOSE 3000
CMD ["sh", "-c", "cd lean4game && npm run start"]
