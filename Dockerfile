FROM php:7.3-cli as basicYii
WORKDIR /home/root
RUN apt-get update && apt-get install -y git-all unzip &&\
    curl -sS https://getcomposer.org/installer | php &&\
    mv composer.phar /usr/local/bin/composer && \
    composer create-project --prefer-dist yiisoft/yii2-app-basic basic


FROM centos/httpd

RUN yum install -y epel-release yum-utils
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php74
RUN yum install -y php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd unzip php-mbstring dom
RUN php --ini

WORKDIR /var/www/html
COPY --from=basicYii /home/root/basic /var/www/html/

COPY conf/default.conf /etc/httpd/conf.d/
EXPOSE 80





