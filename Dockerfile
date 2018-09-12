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

RUN apt-get -y update && \
    apt-get install -y \
        gpg \
        curl && \
        for server in $(shuf -e ha.pool.sks-keyservers.net \
                            hkp://p80.pool.sks-keyservers.net:80 \
                            keyserver.ubuntu.com \
                            hkp://keyserver.ubuntu.com:80 \
                            pgp.mit.edu) ; do \
            gpg --keyserver "$server" --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && break || : ; \
        done && \
    curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture)" && \
    curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$(dpkg --print-architecture).asc" && \
    gpg --verify /usr/local/bin/gosu.asc && \
    rm /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    apt-get remove -y --purge \
        gpg \
        curl && \
    rm -rf /var/lib/apt/lists/*

# Switch to UID and create user inside container to run applications
# with that UID. This fixes the issue of files being created in a shared
# volume
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
