FROM node:boron
MAINTAINER yangboz "z@smartkit.info"

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install app dependencies
COPY tenuki.js/package.json /usr/src/app/
RUN npm install
COPY tenuki.js /usr/src/app/


# Bundle app source
COPY . /usr/src/app

EXPOSE 3000
CMD [ "node", "tenuki.js/test-server/server.js" ]