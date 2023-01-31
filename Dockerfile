FROM node:18.13.0-alpine

ENV NODE_ENV production
WORKDIR /var/www
COPY --chown=node:node . /var/www

RUN corepack enable
RUN corepack prepare pnpm@7.26.2 --activate
COPY ./pnpm-workspace.yaml /var/www/
COPY ./package.json /var/www/
COPY ./pnpm-lock.yaml /var/www/
COPY ./server/ /var/www/server/
RUN pnpm install --filter ./server --prod --frozen-lockfile --ignore-scripts
COPY ./client/dist/ /var/www/client/dist/

CMD "node" "server/index.js"
