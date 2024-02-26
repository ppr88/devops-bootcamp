FROM node:lts-alpine

EXPOSE 3000

RUN mkdir -p /home/app

WORKDIR /home/app
COPY ./app .

RUN npm install

ENTRYPOINT ["npm", "start"]