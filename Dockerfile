FROM python:3.10-slim

LABEL maintainer="Sourav"
LABEL version="1.0"
LABEL description="A simple Python application"

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src

CMD ["python", "src/main.py"]
EXPOSE 5000