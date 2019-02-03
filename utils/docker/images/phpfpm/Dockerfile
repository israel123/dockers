# from https://www.drupal.org/docs/8/system-requirements/drupal-8-php-requirements
FROM php:7.1-fpm

RUN set -ex; \
    apt-get update &&\
    apt-get install -y \
    software-properties-common \
    iputils-ping \
    git \
    mysql-client \
    ;

# install the PHP extensions we need
RUN set -ex; \
	\
	if command -v a2enmod; then \
		a2enmod rewrite; \
	fi; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libjpeg-dev \
		libpng-dev \
		libpq-dev \
	; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install -j "$(nproc)" \
		gd \
		opcache \
		pdo_mysql \
		pdo_pgsql \
		zip \
	; \
	\
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark; \
	ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
		| awk '/=>/ { print $3 }' \
		| sort -u \
		| xargs -r dpkg-query -S \
		| cut -d: -f1 \
		| sort -u \
		| xargs -rt apt-mark manual; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

WORKDIR /var/www/html

	# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/bin
ENV PATH /root/.composer/vendor/bin:$PATH

# Install Drush8
RUN cd /usr/local/bin && \
    mkdir drush-8 && \
    cd drush-8 && \
    composer require drush/drush:8.x && \
    ln -s /usr/local/bin/drush-8/vendor/bin/drush /usr/local/bin/drush8 && \
	echo "DRUSH8 VERSION >>>> $(drush8 --version)"

# Choose a default Drush Version
RUN ln -s /usr/local/bin/drush8 /usr/local/bin/drush

RUN   chown -R www-data:www-data /var/www/html && \
      chown -R www-data:www-data /var/www/html

USER www-data