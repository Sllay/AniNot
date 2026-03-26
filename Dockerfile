FROM selenium/standalone-chrome:latest

USER root

RUN apt-get update -qq && apt-get install -y curl wget unzip && \
    CHROME_VER=$(curl -sf "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_147") && \
    wget -q "https://storage.googleapis.com/chrome-for-testing-public/${CHROME_VER}/linux64/chrome-linux64.zip" -O /tmp/chrome.zip && \
    unzip -q /tmp/chrome.zip -d /opt/ && \
    mv /opt/chrome-linux64 /opt/chrome147 && \
    chmod +x /opt/chrome147/chrome && \
    ln -sf /opt/chrome147/chrome /usr/bin/google-chrome && \
    rm /tmp/chrome.zip && \
    mkdir -p /home/seluser/.local/share/undetected_chromedriver/undetected && \
    chown -R seluser:seluser /home/seluser/.local

COPY patch.py /tmp/patch.py

USER seluser

COPY requirements.txt /home/seluser/app/requirements.txt
WORKDIR /home/seluser/app

RUN pip install --no-cache-dir -r requirements.txt && \
    python3 /tmp/patch.py

CMD ["uvicorn", "anipy_server.main:app", "--host", "0.0.0.0", "--port", "8000"]
