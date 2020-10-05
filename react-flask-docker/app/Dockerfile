FROM node:14.12.0-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .
