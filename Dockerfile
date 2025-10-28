FROM node:18.6.0-alpine

ARG REACT_APP_API_BASE_URL

WORKDIR /user/src/app

COPY package.json .
COPY yarn.lock .

RUN yarn

COPY  . .

RUN yarn build

RUN  npm install -g serve

CMD [ "serve", "-s", "build" ]