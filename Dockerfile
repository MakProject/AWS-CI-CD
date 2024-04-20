# Use an official Node.js runtime as the base image
FROM node:20-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project to the working directory
COPY . .

# Build the React app for production
RUN npm run build

#base image for deploying the app
FROM nginx:alpine

#defining work directory for nginx
WORKDIR /usr/share/nginx/html/

#copying from build stage to nginx
COPY --from=build /app/build/ .

#exposing port 80 for the application output:
EXPOSE 80

#executing application to run in foreground
CMD ["nginx", "-g", "daemon off;"]

