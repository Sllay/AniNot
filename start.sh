#!/bin/sh
echo "nameserver 8.8.8.8" > /etc/resolv.conf
echo "nameserver 1.1.1.1" >> /etc/resolv.conf
exec uvicorn anipy_server.main:app --host 0.0.0.0 --port ${PORT:-8000}
