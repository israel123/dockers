FROM nginx:stable


COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./site.conf /etc/nginx/conf.d/default.conf

RUN touch /var/run/nginx.pid && \
  chown -R www-data:www-data /var/run/nginx.pid && \
  chown -R www-data:www-data /var/cache/nginx

EXPOSE 9080

#RUN mkdir /var/www/
#RUN echo "<?php phpinfo() ?>" > /var/www/index.php
VOLUME /var/www/html

RUN chown -R www-data:www-data /var/www/html

USER www-data
