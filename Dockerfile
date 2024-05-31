# Base image
FROM node:14

# Working directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Bundle app source
COPY . .

# Application port
EXPOSE 3000

# Command to run the app
CMD ["npm", "start"]

