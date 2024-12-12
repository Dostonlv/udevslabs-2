FROM node:20-alpine


WORKDIR /app

COPY udevslabs-lesson2-app/package*.json ./

RUN npm install

COPY udevslabs-lesson2-app/ .

CMD ["node", "app.js"]
