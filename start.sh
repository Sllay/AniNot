#!/bin/sh
echo "=== DIAGNOSTICO DE REDE ==="
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
echo "--- resolv.conf atual ---"
cat /etc/resolv.conf
echo "--- nslookup animepahe.ru ---"
nslookup animepahe.ru || echo "FALHOU: DNS nao resolve"
echo "--- curl animepahe.ru ---"
curl -I https://animepahe.ru/ --max-time 10 || echo "FALHOU: curl nao chegou"
echo "=== FIM DIAGNOSTICO ==="
exec uvicorn anipy_server.main:app --host 0.0.0.0 --port ${PORT:-8000}
