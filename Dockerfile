FROM python:3.11

RUN apt update && apt install -y openssh-server && apt clean

RUN mkdir /var/run/sshd

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt



COPY app.py .

EXPOSE 22 8000

ENV PORT=8000

CMD ["bash", "-c", "service ssh start && exec gunicorn --bind 0.0.0.0:$PORT --timeout 600 --access-logfile - --error-logfile - app:app"]