FROM python:3.11

RUN apt update && apt install -y openssh-server && apt clean

RUN mkdir /var/run/sshd

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN sed -i 's/\r$//' start.sh
RUN chmod +x start.sh

EXPOSE 22 8000

ENV PORT=8000

CMD ["bash", "-c", "./start.sh"]