# Node.js ilovasi uchun Alpine tasviri
FROM node:20-alpine

# Ishlash papkasini sozlash
WORKDIR /app

COPY udevslabs-lesson2-app/package*.json ./

RUN npm install

COPY udevslabs-lesson2-app/ .

CMD ["node", "app.js"]
