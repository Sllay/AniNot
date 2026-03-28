#!/bin/bash

# Instala cloudflared se nao existir
if ! command -v cloudflared &> /dev/null; then
  curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    -o /usr/local/bin/cloudflared
  chmod +x /usr/local/bin/cloudflared
fi

# Sobe DNS over HTTPS na porta 5353
cloudflared proxy-dns --port 5353 --upstream https://1.1.1.1/dns-query &
sleep 3

# Força sistema usar nosso DNS local
echo "nameserver 127.0.0.1" > /etc/resolv.conf
printf "options ndots:0
" >> /etc/resolv.conf

# Diagnóstico
echo "=== DIAGNOSTICO DE REDE ==="
nslookup -port=5353 animepahe.ru 127.0.0.1 && echo "OK: DNS resolve" || echo "FALHOU: DNS nao resolve"
curl -s -o /dev/null -w "curl HTTP: %{http_code}
" https://animepahe.ru || echo "FALHOU: curl nao chegou"
echo "=== FIM DIAGNOSTICO ==="

uvicorn anipy_server.main:app --host 0.0.0.0 --port 8080
