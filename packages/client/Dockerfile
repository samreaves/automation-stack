# Begin with Linux distro with only node installed
FROM node:latest

# I am the wizard who conjured this machine
MAINTAINER Sam Reaves

# On container start, build src directory inside
RUN mkdir /client

# Install global node monitor
RUN npm i nodemon -g
RUN npm i yarn

# Set src directory as default directory for start command
WORKDIR /client

# Add local current directory to container's src directory
ADD . /client

# Install dependencies
RUN yarn install

# Open port 3000
EXPOSE 3000

# It's business time
CMD yarn start
