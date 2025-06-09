# crud-app

1. project setup
- create env file
- src folder
- requirements.txt
- __init__.py
- models.py
- routes.py
- main.py
- add __pycache__ to gitignore
- terraform folder
- main.tf , variables.tf , terraform.tfvars
- Dockerfile
- deployment.yaml
- Jenkinsfile

2. Basic Setup
# main.py
```
from flask import Flask

app = Flask(__name__)

@app.route('/', methods=['GET'])
def hello_world():
    return "Hello World!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
```

# Dockerfile
```
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
```

Test Locally
Test in Docker container

3. Push to DockerHUB
docker build -t crud-app .
docker run -p 5000:5000 crud-app

docker login -u sourav7
docker tag crud-app sourav7/crud-app:latest
docker push sourav7/crud-app:latest

4. Create Terraform with AWS provider

Test with AWS IP