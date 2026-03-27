FROM ultrafunk/undetected-chromedriver

USER root

RUN apt-get update -qq && apt-get install -y python3 python3-pip && \
    mkdir -p /home/seluser/.local/share/undetected_chromedriver/undetected && \
    chmod -R 777 /home/seluser/.local

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV PYTHONUNBUFFERED=1

CMD ["/start.sh"]
