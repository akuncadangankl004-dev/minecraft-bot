# WARNING:
#
# This Dockerfile uses contents of current folder which might contain
# secrets, uncommitted changes or other sensitive information. DO NOT
# publish the result image unless it was composed in a clean environment.

ARG NODE_IMAGE=docker.io/node:alpine

FROM --platform=$BUILDPLATFORM ${NODE_IMAGE} as nodebuild

WORKDIR /app

# Copy project files
COPY . .

# Fetch dependencies from npm
RUN npm install

# Build assets
RUN npm run

# Now get the clean Node.js image
FROM ${NODE_IMAGE} as minecraft-bot

WORKDIR /app

# Copy sources
COPY --from=nodebuild /app ./

CMD [ "npm", "start" ]