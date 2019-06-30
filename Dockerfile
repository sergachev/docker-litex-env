FROM lerwys/litex

# LABEL \
#       com.github.lerwys.docker.dockerfile="Dockerfile" \
#       com.github.lerwys.vcs-type="Git" \
#       com.github.lerwys.vcs-url="https://github.com/lerwys/docker-litex-env.git"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get install -y --no-install-recommends \
        libmpc-dev \
        libmpfr-dev \
        libgmp-dev \
        libtool \
        libz-dev \
        libexpat1-dev \
	libx11-6 \
        gosu && \
    rm -rf /var/lib/apt/lists/*

# Switch to UID and create user inside container to run applications
# with that UID. This fixes the issue of files being created in a shared
# volume
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
