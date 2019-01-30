FROM php:7.1.0-apache
MAINTAINER Bender77 <bryan@bwirth.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt update -y && \
	apt install -y curl \
	libpng-dev \
	wget && \
	apt install libmagickwand-dev --no-install-recommends -y && \
	pecl install imagick && docker-php-ext-enable imagick && \
	docker-php-ext-install pdo_mysql && \
	docker-php-ext-install gd && \
	apt-get clean && apt-get autoclean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/www/html/* && \
	a2enmod rewrite
RUN wget -O /zenphoto.tar.gz https://github.com/zenphoto/zenphoto/archive/v1.5.1.tar.gz
#RUN sed -i "/upload_max_filesize/c\upload_max_filesize = 60M" /etc/php/7.1/apache2/php.ini && \
RUN echo "<Directory /var/www>" >> /etc/apache2/sites-available/000-default.conf && \
echo "	AllowOverride All" >> /etc/apache2/sites-available/000-default.conf && \
echo "	Options -Indexes +FollowSymLinks" >> /etc/apache2/sites-available/000-default.conf && \
echo "</Directory>" >> /etc/apache2/sites-available/000-default.conf && \
sed -i "/<\/VirtualHost>/d" /etc/apache2/sites-available/000-default.conf && \
echo "</VirtualHost>" >> /etc/apache2/sites-available/000-default.conf
ADD run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 80
CMD ["/bin/bash","/run.sh"]
