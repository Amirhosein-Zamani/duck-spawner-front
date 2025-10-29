FROM node:18.6.0-alpine AS builder

ARG REACT_APP_API_BASE_URL

WORKDIR /usr/src/app

COPY package.json .
COPY yarn.lock .

RUN yarn
COPY  . .
RUN yarn build

FROM node:18.6.0-alpine AS serve-setup

RUN npm install -g serve

FROM alpine AS production

COPY --from=serve-setup /usr/local/bin/serve /usr/local/bin/serve
COPY --from=serve-setup /usr/lib/node_modules/serve/ /usr/lib/node_modules/serve/

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/build ./build

CMD [ "serve", "-s", "build" ]