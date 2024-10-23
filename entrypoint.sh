#!/bin/bash

PASSWORD="${PASSWORD:-$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 16)}"
PORT="${PORT:-8388)}"
METHOD="${METHOD:-chacha20-ietf-poly1305')}"

cat > /etc/shadowsocks-libev/config.json <<EOF
{
  "server":"0.0.0.0",
  "server_port":${PORT},
  "password":"${PASSWORD}",
  "timeout":300,
  "method":"${METHOD}",
  "fast_open": false,
  "nameserver":"1.0.0.1",
  "mode":"tcp_and_udp",
  "plugin":"obfs-server",
  "plugin_opts":"obfs=tls"
}
EOF

HOST_IP=$(curl -s https://ipinfo.io/ip)

qrencode -o - -t UTF8 "ss://$(echo -n "${METHOD}:${PASSWORD}@${HOST_IP}:${PORT}" | base64 -w 0)"

exec ss-server -c /etc/shadowsocks-libev/config.json
