FROM selenium/standalone-chrome:latest

USER root

RUN CHROME_VER=$(google-chrome --version | grep -oP 'd+.d+.d+.d+' | head -1) && \
    echo "Chrome: $CHROME_VER" && \
    wget -q "https://storage.googleapis.com/chrome-for-testing-public/$CHROME_VER/linux64/chromedriver-linux64.zip" -O /tmp/cd.zip && \
    unzip /tmp/cd.zip -d /tmp/cd && \
    UC_DIR="/home/seluser/.local/share/undetected_chromedriver/undetected" && \
    mkdir -p $UC_DIR && \
    cp /tmp/cd/chromedriver-linux64/chromedriver "$UC_DIR/chromedriver_PATCHED" && \
    chmod +x "$UC_DIR/chromedriver_PATCHED" && \
    chown -R seluser:seluser /home/seluser/.local && \
    rm -rf /tmp/cd /tmp/cd.zip

USER seluser

COPY requirements.txt /home/seluser/app/requirements.txt
WORKDIR /home/seluser/app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "anipy_server.main:app", "--host", "0.0.0.0", "--port", "8000"]
