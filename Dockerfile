FROM nginx:1.31.2-alpine

# Remove default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy static files
COPY ./site /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]