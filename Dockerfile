# Static resume site served by nginx — no PHP, no database,
# no plugin updates, no attack surface beyond the web server itself.
FROM nginx:1.31.2-alpine

# Remove the listen on IPV6 by default script.
RUN rm -f /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh

# Remove the default nginx welcome page config
RUN rm -f /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html style.css script.js /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost/ > /dev/null || exit 1
