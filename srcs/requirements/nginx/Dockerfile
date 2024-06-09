# Use the official Debian Bullseye image
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && \
    apt-get install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

# Copy your SSL certificate and key to the container
# Make sure you replace these with your actual certificate and key files
COPY ./certs/server.crt /etc/nginx/ssl/server.crt
COPY ./certs/server.key /etc/nginx/ssl/server.key

# Copy the NGINX configuration file
COPY ./nginx.conf /etc/nginx/nginx.conf

# Expose port 443 for HTTPS
EXPOSE 443

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
