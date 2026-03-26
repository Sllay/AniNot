FROM selenium/standalone-chrome:latest

USER root

RUN CHROME_VER=$(google-chrome --version | grep -oP 'd+' | head -1) && \
    UC_DIR="/home/seluser/.local/share/undetected_chromedriver" && \
    mkdir -p $UC_DIR && \
    ln -sf /usr/bin/chromedriver "$UC_DIR/chromedriver_PATCHED"

USER seluser

COPY . /home/seluser/app
WORKDIR /home/seluser/app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
