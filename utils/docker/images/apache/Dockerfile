# Development Website Template
# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Linnovate Devops

# Directory commands are exec from automatically
WORKDIR /var/www/html

# APT-GET  #####################################################

# Modify sources
#RUN sed -i -e 's/archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# Prevent Apt from ever hanging by making the following settings changes

# Some repos have issues with http/1.1 pipelining.
# Sometimes its hard to see which repos are failing because of long timeouts so reduce the timeouts
# Force IP V4 to disable attempting to resolve IP V6
# Set Apt/DESELECT to Always Clean Cache

RUN echo 'Acquire::http::Pipeline-Depth "0";' | tee /etc/apt/apt.conf.d/99pipelining-off && \
echo 'Acquire::http::Timeout "5";' | tee /etc/apt/apt.conf.d/99reduce-timeout && \
echo 'Acquire::ForceIPv4 "true";' | tee /etc/apt/apt.conf.d/99force-ipv4 && \
echo 'DSELECT::Clean "always";' | tee /etc/apt/apt.conf.d/99always-clean-dselect && \
echo 'APT::Get::Clean=always;' | tee /etc/apt/apt.conf.d/99always-clean-apt && \
echo "configured apt settings"

# runin noninteractive mode to Auto configure everything
ENV DEBIAN_FRONTEND=noninteractive

# this should probably be manually run once a month
# RUN apt-get clean && apt-get update && apt-get dist-upgrade -y

# Install custom ppas
RUN apt-get clean && apt-get update && apt-get install -y \
    software-properties-common && \
    add-apt-repository -y ppa:certbot/certbot

RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php

# Update the repository sources list
# Utility for apt configuration
# Upgrade packages
# Install standard LAMP environment
# Install specific dependencies
# Install system tools (postfix included in mailutils)
# Install administration tools, procps for top, pv progress viewer
# Install certbot

RUN apt-get clean && apt-get update && apt-get install -y \
    apt-utils \
    apache2 php7.2 libapache2-mod-php7.2 php7.2-mysql php7.2-mbstring \
	php7.2-curl php7.2-gd php7.2-xml php7.2-zip php7.2-bcmath \
    mailutils \
    vim mysql-client net-tools telnet sudo procps ssh inetutils-ping realpath tree pv curl wget \
    python-certbot-apache \
	git

# Install rsyslog for php logs
# Install php-memcached for memcache integration
RUN apt-get clean && apt-get update && apt-get install -y \
    rsyslog php-memcached
# COPY FILES  #####################################################

# Install Redis support
RUN apt-get clean && apt-get update && apt-get install -y \
    --allow-unauthenticated \
    php-redis
# add custom PHP ini
# COPY php.ini /etc/php/7.0/apache2/php.ini

# add custom apache conf (htaccess)
#COPY apache2.conf /etc/apache2/apache2.conf

# add custom root site conf, case the user will add more confs in /etc/apache2/sites-available
#COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# add basic ssl support (does not enable ssl site though)
#COPY default-ssl.conf /etc/apache2/sites-available/default-ssl.conf

RUN a2enmod ssl
# eventually we need to add ssl files or generate our own.
# the default-ssl file takes
# SSLCertificateFile    /etc/ssl/certs/ssl.crt
# SSLCertificateKeyFile /etc/ssl/private/ssl.key

# SETUP #####################################################

# Patch in case sendmail was installed before and messed things up for our postfix install via mailutils
# http://wayilearn.blogspot.co.il/2011/11/fixing-error-postdrop-warning-unable-to.html
#RUN mkfifo /var/spool/postfix/public/pickup

# Enable Apache Mods
RUN a2enmod rewrite

# Get latest drush
#RUN php -r "readfile('https://s3.amazonaws.com/files.drush.org/drush.phar');" > drush
# or check https://github.com/drush-ops/drush/releases

# Install Composer, Drush7, and Drush8
# https://modulesunraveled.com/blog/install-drush-7-and-8-and-automatically-switch-versions-based-project
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
	echo "COMPOSER VERSION >>>> $(composer --version)"

# Install Drush8
RUN cd /usr/local/bin && \
    mkdir drush-8 && \
    cd drush-8 && \
    composer require drush/drush:8.x && \
    ln -s /usr/local/bin/drush-8/vendor/bin/drush /usr/local/bin/drush8 && \
	echo "DRUSH8 VERSION >>>> $(drush8 --version)"

# Install Drush7
RUN cd /usr/local/bin && \
    mkdir drush-7 && \
    cd drush-7 && \
    composer require drush/drush:7.x && \
    ln -s /usr/local/bin/drush-7/vendor/bin/drush /usr/local/bin/drush7 && \
	echo "DRUSH7 VERSION >>>> $(drush7 --version)"

# Choose a default Drush Version
RUN ln -s /usr/local/bin/drush8 /usr/local/bin/drush

# Get wordpress cli
#RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
#chmod +x wp-cli.phar && \
#mv wp-cli.phar /usr/local/bin/wp

# Clear cache, skip this for now
# RUN cd /var/www/html/sites/default; drush cc all


# For now we are happy with php logs going to parent process (apache2) logs
# Enable rsyslog for php
# RUN sed -i -e 's/^\;error_log = syslog/error_log = syslog/' -e 's/\^error_log = php_errors.log/;error_log = php_errors.log/' /etc/php/7.0/apache2/php.ini

# ENTRYPOINT #####################################################

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT entrypoint.sh


RUN apt-get install php-xdebug
RUN echo zend_extension="/usr/lib/php/20151012/xdebug.so" >> /etc/php/7.2/apache2/php.ini
RUN echo zend_extension="/usr/lib/php/20151012/xdebug.so" >> /etc/php/7.2/apache2/php.ini
RUN echo "xdebug.remote_enable=on" >> /etc/php/7.2/apache2/php.ini
RUN echo "xdebug.remote_autostart=true" >> /etc/php/7.2/apache2/php.ini
RUN echo "xdebug.remote_handler=dbgp" >> /etc/php/7.2/apache2/php.ini
RUN echo "xdebug.remote_mode=req" >> /etc/php/7.2/apache2/php.ini
RUN echo "xdebug.remote_port=9000" >> /etc/php/7.2/apache2/php.ini
RUN echo "xdebug.remote_host=172.17.0.1" >> /etc/php/7.2/apache2/php.ini
RUN echo "xdebug.remote_log=/var/log/xdebug_remote.log" >> /etc/php/7.2/apache2/php.ini
RUN echo "xdebug.idekey=PHPSTORM" >> /etc/php/7.2/apache2/php.ini
RUN echo "xdebug.remote_connect_back=On" >> /etc/php/7.2/apache2/php.ini
