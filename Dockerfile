FROM ultrafunk/undetected-chromedriver

USER root

RUN apt-get update -qq && apt-get install -y python3 python3-pip curl dnsutils

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV PYTHONUNBUFFERED=1

CMD ["/start.sh"]
# cache bust Fri Mar 27 22:25:28 -03 2026
