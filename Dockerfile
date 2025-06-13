FROM python:3.11

RUN apt update && apt install -y openssh-server

RUN mkdir /var/run/sshd

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 22 8000

CMD service ssh start && gunicorn -b 0.0.0.0:8000 app:app
