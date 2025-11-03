# Use Nginx as base image
FROM nginx:alpine

# Copy your static HTML page into Nginx web root
COPY index.html /usr/share/nginx/html/index.html

# Expose default HTTP port
EXPOSE 80
