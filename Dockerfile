FROM lerwys/litex

LABEL \
      com.github.lerwys.docker.dockerfile="Dockerfile" \
      com.github.lerwys.vcs-type="Git" \
      com.github.lerwys.vcs-url="https://github.com/lerwys/docker-litex-env.git"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get install -y \
        libmpc-dev \
        libmpfr-dev \
        libgmp-dev \
        libtool \
        libz-dev \
        libexpat1-dev && \
    rm -rf /var/lib/apt/lists/*
