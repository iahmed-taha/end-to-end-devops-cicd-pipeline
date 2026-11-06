# Use official NGINX image
FROM nginx:alpine

# Copy application files into NGINX
COPY app/ /usr/share/nginx/html/

# Expose application port
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]