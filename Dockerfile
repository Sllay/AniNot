FROM selenium/standalone-chrome:latest

USER root

RUN mkdir -p /home/seluser/.local/share/undetected_chromedriver/undetected && \
    cp /usr/bin/chromedriver /home/seluser/.local/share/undetected_chromedriver/undetected/chromedriver_PATCHED && \
    chmod +x /home/seluser/.local/share/undetected_chromedriver/undetected/chromedriver_PATCHED && \
    chown -R seluser:seluser /home/seluser/.local

USER seluser

COPY requirements.txt /home/seluser/app/requirements.txt
WORKDIR /home/seluser/app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["uvicorn", "anipy_server.main:app", "--host", "0.0.0.0", "--port", "8000"]
