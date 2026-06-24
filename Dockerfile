# Static resume site served by nginx — no PHP, no database,
# no plugin updates, no attack surface beyond the web server itself.
FROM nginx:1.31.2-alpine

COPY default.conf /etc/nginx/conf.d/default.conf
COPY index.html style.css script.js /usr/share/nginx/html/
COPY assets /usr/share/nginx/html/assets

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost/ > /dev/null || exit 1
