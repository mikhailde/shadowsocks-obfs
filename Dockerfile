FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential autoconf libtool libssl-dev libpcre3-dev \
        libev-dev asciidoc xmlto automake gettext pkg-config \
        libmbedtls-dev libsodium-dev libc-ares-dev ca-certificates \
        wget git qrencode curl && \
    # Сборка Shadowsocks-libev
    wget https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.3.5/shadowsocks-libev-3.3.5.tar.gz && \
    tar -xzf shadowsocks-libev-3.3.5.tar.gz && \
    cd shadowsocks-libev-3.3.5 && \
    ./configure && \
    make && \
    make install && \
    cd .. && rm -rf shadowsocks-libev-3.3.5* && \
    # Сборка Simple-obfs
    git clone https://github.com/shadowsocks/simple-obfs.git && \
    cd simple-obfs && \
    git submodule update --init --recursive && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd .. && rm -rf simple-obfs && \
    # Очистка временных файлов и ненужных пакетов
    apt-get remove --purge -y build-essential autoconf libtool wget git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN mkdir /etc/shadowsocks-libev && \
    chown nobody:65534 /etc/shadowsocks-libev

ENTRYPOINT ["/entrypoint.sh"]

USER nobody
