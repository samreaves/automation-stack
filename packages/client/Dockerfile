# Begin with Linux distro with only node installed
FROM node:9-alpine

# I am the wizard who conjured this machine
MAINTAINER Sam Reaves

# On container start, build src directory inside
RUN mkdir /client

# Set src directory as default directory for start command
WORKDIR /client

# Add local current directory to container's src directory
ADD . /client

# Install dependencies
RUN npm install

# Open port 3000
EXPOSE 3000

# It's business time
CMD npm start
