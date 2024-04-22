# FROM arm64v8/node:21-bullseye AS build
FROM --platform=linux/arm64/v8 node:20-bullseye AS build
WORKDIR /app
COPY package*.json /app
RUN --mount=type=secret,mode=0644,id=npmrc,target=/app/.npmrc npm ci

FROM --platform=linux/arm64/v8 node:20-bullseye
# FROM arm64v8/node:21-bullseye

ENV TINI_VERSION v0.19.0
# ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-arm64  /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

ENV NODE_ENV=production

WORKDIR /app
COPY --chown=node:node --from=build /app/node_modules /app/node_modules
COPY index.js /app
COPY dice.js /app

RUN chown -R node:node /app
USER node

CMD ["node","index.js"]
EXPOSE 8080