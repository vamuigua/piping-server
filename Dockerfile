FROM node:12.18.0-alpine

LABEL maintainer="Ryo Ota <nwtgck@nwtgck.org>"

RUN apk add --no-cache tini

COPY . /app

# Move to /app
WORKDIR /app

# Install requirements, build and remove devDependencies
# (from: https://stackoverflow.com/a/25571391/2885946)
RUN npm ci && \
    npm run build && \
    npm prune --production

# Run a server
ENTRYPOINT [ "tini", "--", "node", "dist/src/index.js" ]
