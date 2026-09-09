FROM node:20

WORKDIR /

COPY ./lean-toolchain /lean-toolchain

# The `lean4game` revision to check out is read from `lake-manifest.json`, so that the
# frontend/server we run and the `GameServer` package we build against are always the
# same revision. Note we cannot derive it from `lean-toolchain`: `lean4game` has no
# release tag for every Lean version (e.g. there is none for v4.26.0).
COPY ./lake-manifest.json /lake-manifest.json

USER node

WORKDIR /home/node

RUN LEAN4GAME_REV="$(node -e 'const p = require("/lake-manifest.json").packages.find(p => p.name === "GameServer"); if (!p) { console.error("No GameServer package in lake-manifest.json; run `lake update -R`."); process.exit(1) } process.stdout.write(p.rev)')" && \
  echo "Cloning lean4game at $LEAN4GAME_REV" && \
  mkdir lean4game && \
  cd lean4game && \
  git init -q . && \
  git remote add origin https://github.com/leanprover-community/lean4game.git && \
  git fetch --depth 1 origin "$LEAN4GAME_REV" && \
  git checkout -q FETCH_HEAD

WORKDIR /

USER root

ENV ELAN_HOME=/usr/local/elan \
  PATH=/usr/local/elan/bin:$PATH

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

RUN export LEAN_VERSION="$(cat /lean-toolchain)" && \
  curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y --no-modify-path --default-toolchain $LEAN_VERSION; \
    chmod -R a+w $ELAN_HOME; \
    elan --version; \
    lean --version; \
    leanc --version; \
    lake --version;

# Debian's `/etc/profile` overwrites PATH, which hides the elan installation from login
# shells -- and that is how VSCode starts its integrated terminal, where the documented
# workflow is to run `lake build` after editing Lean files. Put elan back on PATH there.
RUN echo 'export PATH="/usr/local/elan/bin:$PATH"' > /etc/profile.d/elan.sh
