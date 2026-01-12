FROM lscr.io/linuxserver/webtop:ubuntu-mate

ARG APT_MIRROR=mirrors.aliyun.com
RUN set -eux; \
  rm -f /etc/apt/sources.list.d/nodesource.list /etc/apt/sources.list.d/nodesource.list.save; \
  sed -i "s|http://archive.ubuntu.com/ubuntu/|http://${APT_MIRROR}/ubuntu/|g" /etc/apt/sources.list; \
  sed -i "s|http://security.ubuntu.com/ubuntu/|http://${APT_MIRROR}/ubuntu/|g" /etc/apt/sources.list; \
  apt-get update; \
  apt-get install -y --no-install-recommends \
    git \
    curl \
    ca-certificates \
    zsh \
    build-essential \
    python3 \
    python3-pip \
    nodejs \
    npm; \
  apt-get clean; \
  rm -rf /var/lib/apt/lists/*
