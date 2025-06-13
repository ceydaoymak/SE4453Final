FROM python:3.11

RUN apt update && apt install -y openssh-server

RUN mkdir /var/run/sshd

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
COPY start.sh .

RUN chmod +x start.sh

EXPOSE 22 8000

CMD ["./start.sh"]
