# Use the official Node.js image as the base image
FROM node:14 as build

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the project dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the Angular app
RUN npm run build

# Use a lightweight HTTP server as the base image
FROM nginx:latest

# Copy the built Angular app from the previous stage to the Nginx container
COPY --from=build /app/dist/student-ang-app /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the default Nginx port
EXPOSE 80
