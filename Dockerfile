FROM python:3.11

RUN apt update && apt install -y openssh-server

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

RUN mkdir /var/run/sshd

EXPOSE 8000 22

CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]
