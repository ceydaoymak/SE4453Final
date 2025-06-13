FROM python:3.11

RUN apt update && apt install -y openssh-server

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN mkdir /var/run/sshd

EXPOSE 3000 22

CMD ["bash", "start.sh"]
