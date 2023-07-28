FROM node:lts-slim

# RUN npm install axios
#RUN yarn add axios axios-case-converter --save
# RUN npm add -D @types/axios
WORKDIR /front

RUN npm install axios axios-case-converter
RUN npm install -D @types/axios

ENV CI=true
