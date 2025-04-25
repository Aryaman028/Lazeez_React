# Use a lightweight Node.js image
FROM node:18-alpine 

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to leverage caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire project
COPY . .

# Build the React app
RUN npm run build

# Use Nginx to serve the built files
FROM nginx:alpine

# Copy the build output to Nginx's default public directory
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]