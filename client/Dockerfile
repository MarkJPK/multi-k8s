# Dockerfile for production purposes

# Build Phase
FROM node:16-alpine AS builder

# Change the working directory
WORKDIR '/app'

# Copy the package.json file and install the dependencies
COPY package.json .
RUN npm install

# Copy the source files
COPY . .

# Build the application
RUN npm run build

# Run Phase
FROM nginx

# Export the listener port
EXPOSE 3000

# Copy the NGINX configuration
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Copy the result of the Build phase to the Nginx static directory
COPY --from=builder /app/build /usr/share/nginx/html