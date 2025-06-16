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

5. Setup Github Webhook for CICD

# Add Docker Plugin
Manage Jenkins > Plugins > Available Plugins > Docker > Install > Restart after installation
# Add Dockerhub credentials
Go to Jenkins Dashboard → Manage Jenkins → Credentials.

Create a New Pipeline Job:

In Jenkins, click "New Item".
Enter a name for your job (e.g., crud-app-pipeline).
Select "Pipeline" and click OK.
Configure Pipeline from SCM:

Scroll down to the "Pipeline" section.
For "Definition", select "Pipeline script from SCM".
For "SCM", select "Git".
In "Repository URL", enter your Git repository’s URL (e.g., https://github.com/yourusername/crud-app.git).
If your repo is private, add credentials for Git access.
"Script Path" should be Jenkinsfile (this is the default; only change if your Jenkinsfile is in a subfolder).
Save and Build:

Click Save.
Click Build Now to run your pipeline.

- Add plugins for Docker, Docker pipeline, SSH Agent
- Add credentials for dockerhub, ec2 host(ip address), ec2-ssh-key

Test Jenkins Trigger
