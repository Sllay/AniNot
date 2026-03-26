FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    chromium chromium-driver \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_PATH=/usr/bin/chromedriver

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

EXPOSE 8000
CMD ["anipy"]
