# Use Nginx for static site
FROM nginx:alpine

# Copy index.html
COPY index.html /usr/share/nginx/html/index.html

# Copy images folder
COPY images/ /usr/share/nginx/html/images/

# Expose port 80
EXPOSE 80
