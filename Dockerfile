FROM node:18

WORKDIR /app
COPY . .

RUN npm install

EXPOSE 22
EXPOSE 3000

CMD ["bash", "start.sh"]