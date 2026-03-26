FROM selenium/standalone-chrome:latest

USER root

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

EXPOSE 10000
CMD ["anipy"]
