FROM ultrafunk/undetected-chromedriver

USER root

RUN apt-get update -qq && apt-get install -y python3 python3-pip python3-venv && \
    mkdir -p /home/seluser/.local/share/undetected_chromedriver/undetected && \
    chmod -R 777 /home/seluser/.local

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

ENV PYTHONUNBUFFERED=1

CMD ["uvicorn", "anipy_server.main:app", "--host", "0.0.0.0", "--port", "8000"]
