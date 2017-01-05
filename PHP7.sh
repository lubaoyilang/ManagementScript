#!/bin/bash
# 文件名: PHP7.sh
# 描述:  用于 CentOS 7 系统使用编译安装 PHP7
# 版本:  1.0
# 创建时间:  2016年11月28日
# 修订:  none
# 作者:  Selphia (sp), admin@factory.moe

# 变量
yum -y install libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel pcre-devel curl-devel libxslt-devel ImageMagick

php='php-7.1.0'
php_download=\
'http://jp2.php.net/distributions/php-7.1.0.tar.xz'


wget $php_download
tar -xvf $php.tar.xz
cd $php

./configure --prefix=/usr/local/php7 \
	--with-apxs2=/usr/local/apache/bin/apxs \
	--with-curl \
 	--with-freetype-dir \
	--with-gd \
	--with-gettext \
	--with-iconv-dir \
	--with-kerberos \
	--with-libdir=lib64 \
	--with-libxml-dir \
	--with-openssl \
	--with-pcre-regex \
	--with-pear \
	--with-png-dir \
	--with-xmlrpc \
	--with-xsl \
	--with-zlib \
	--enable-fpm \
	--enable-bcmath \
	--enable-libxml \
	--enable-inline-optimization \
	--enable-gd-native-ttf \
	--enable-mbregex \
	--enable-mbstring \
	--enable-opcache \
	--enable-pcntl \
	--enable-shmop \
	--enable-soap \
	--enable-sockets \
	--enable-sysvsem \
	--enable-xml \
	--enable-zip \
	--enable-apcu-bc \
	--with-mysqli \
	--with-pdo-mysql \
	--with-pdo-sqlite \
	--with-pgsql \
	--with-pdo-pgsql

# 安装
make
make install

# 快捷方式
ln -s /usr/local/php7/bin/* /usr/bin/
build/shtool install -c ext/phar/phar.phar /usr/local/php7/bin
ln -s -f phar.phar /usr/local/php7/bin/phar

# 退出
exit 0