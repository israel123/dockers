FROM linnovate/web:16.04
WORKDIR /var/www/html

RUN apt-get install php-xdebug
RUN echo zend_extension="/usr/lib/php/20151012/xdebug.so" >> /etc/php/7.0/apache2/php.ini
RUN echo "xdebug.remote_enable=on" >> /etc/php/7.0/apache2/php.ini
RUN echo "xdebug.remote_autostart=true" >> /etc/php/7.0/apache2/php.ini
RUN echo "xdebug.remote_handler=dbgp" >> /etc/php/7.0/apache2/php.ini
RUN echo "xdebug.remote_mode=req" >> /etc/php/7.0/apache2/php.ini
RUN echo "xdebug.remote_port=9000" >> /etc/php/7.0/apache2/php.ini
RUN echo "xdebug.remote_host=172.17.0.1" >> /etc/php/7.0/apache2/php.ini
RUN echo "xdebug.remote_log=/var/log/xdebug_remote.log" >> /etc/php/7.0/apache2/php.ini
RUN echo "xdebug.idekey=PHPSTORM" >> /etc/php/7.0/apache2/php.ini
RUN echo "xdebug.remote_connect_back=On" >> /etc/php/7.0/apache2/php.ini


RUN curl https://drupalconsole.com/installer -L -o drupal.phar
RUN mv drupal.phar /usr/local/bin/drupal
RUN chmod +x /usr/local/bin/drupal
RUN drupal init # fill form