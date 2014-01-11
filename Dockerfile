FROM ubuntu:12.04
MAINTAINER Daekwon Kim <propellerheaven@gmail.com>

# Run upgrades
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# Install basic packages
RUN apt-get -qq -y install git curl build-essential

# Install Apache2
RUN apt-get -qq -y install apache2
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN a2enmod rewrite 

# Install php
RUN apt-get -qq -y install php5
RUN apt-get -qq -y install libapache2-mod-php5 php5-mysql php5-gd

# Install Mysql
RUN apt-get -qq -y install mysql-server mysql-client libmysqlclient-dev
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Install Gnuboard5
RUN cd /tmp
RUN curl -o /tmp/gnu.tar.gz -L -O "http://sir.co.kr/bbs/download_direct.php?bo_table=g5_pds&wr_id=1323&no=0"
RUN tar xf /tmp/gnu.tar.gz
RUN mv g5-5.0b16 /var/www/gnuboard5
RUN mkdir -p /var/www/gnuboard5/data
RUN chown -R www-data:www-data /var/www/gnuboard5
RUN chmod 777 /var/www/gnuboard5

EXPOSE 80
ADD boot.sh /srv/boot.sh
RUN chmod +x /srv/boot.sh

CMD ["/bin/bash", "/srv/boot.sh"]
