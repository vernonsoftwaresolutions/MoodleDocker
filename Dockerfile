FROM ubuntu:16.04
MAINTAINER Sergio Gómez <sergio@quaip.com>

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install software-properties-common python-software-properties -y

# Basic Requirements
RUN apt-get -y install mysql-client pwgen python-setuptools curl git unzip

# Moodle Requirements
RUN apt-get -y install apache2 php php-gd libapache2-mod-php postfix wget supervisor php-pgsql vim curl libcurl3 libcurl3-dev php-curl php-xmlrpc php-intl php-mysql php-mbstring php-soap
RUN apt-get install php7.0-xml -y
#add zip extension
RUN echo 'extension=zip.so' >> /etc/php/7.0/apache2/php.ini 

# SSH
RUN apt-get -y install openssh-server
RUN mkdir -p /var/run/sshd

RUN easy_install supervisor
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
# Moodle files
ADD https://download.moodle.org/stable33/moodle-3.3.tgz /var/www/moodle-latest.tgz
RUN cd /var/www; tar zxvf moodle-latest.tgz; mv /var/www/moodle /var/www/html
RUN chown -R www-data:www-data /var/www/html/moodle
#COPY /tmp/config/config.php /var/www/html/moodle
#ADD https://s3.amazonaws.com/moodle-elasticbeanstalk-deployables-us-east-1/tenant1/config/tenant1/config.php /var/www/moodle
RUN mkdir /var/moodledata
RUN chown -R www-data:www-data /var/moodledata; chmod 777 /var/moodledata
RUN chmod 755 /start.sh /etc/apache2/foreground.sh

EXPOSE 22 80
CMD ["/bin/bash", "/start.sh"]


