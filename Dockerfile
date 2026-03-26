FROM selenium/standalone-chrome:latest

USER root

RUN apt-get update -qq && \
    VER=$(curl -sf https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_147) && \
    echo "Instalando Chrome $VER" && \
    wget -q "https://storage.googleapis.com/chrome-for-testing-public/${VER}/linux64/chrome-linux64.zip" -O /tmp/chrome.zip && \
    unzip -q /tmp/chrome.zip -d /tmp/ && \
    cp /tmp/chrome-linux64/chrome /usr/bin/google-chrome && \
    chmod +x /usr/bin/google-chrome && \
    rm -rf /tmp/chrome.zip /tmp/chrome-linux64 && \
    mkdir -p /home/seluser/.local/share/undetected_chromedriver/undetected && \
    chown -R seluser:seluser /home/seluser/.local

USER seluser

COPY requirements.txt /home/seluser/app/requirements.txt
WORKDIR /home/seluser/app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "anipy_server.main:app", "--host", "0.0.0.0", "--port", "8000"]
