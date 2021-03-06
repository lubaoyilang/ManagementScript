#!/bin/bash
# 文件名: Apache2.sh
# 描述:  用于 CentOS 7 系统编译安装 Apache2
# 版本:  2.0
# 创建时间:  2016.11.17
# 修订时间:  2017.1.4
# 作者:  Selphia (sp), admin@factory.moe

# 变量
apache_download=\
'http://mirrors.hust.edu.cn/apache//httpd/httpd-2.4.25.tar.bz2'
apache="httpd-2.4.25"

# 下载
wget $apache_download
tar -xvf $apache.tar.bz2
cd ./$apache

# 编译
./configure \
	--prefix=/usr/local/apache \
	--enable-so \
	--enable-cgi \
	--enable-ssl \
	--enable-rewrite \
	--enable-deflate \
	--enable-expires \
	--enable-headers \
	--with-zlib \
	--with-pcre \
	--enable-modules=all \
	--enable-mpms-shared=all

# 安装
make all
make install

# 创建链接
ln -s /usr/local/apache/bin/* /usr/bin

# 启动
apachectl -k start

# 创建用户
groupadd -r apache
useradd apache -g apache -r -M -s /sbin/nologin
chown -R apache:apache /usr/local/apache
sed -i 's/User daemon/User apache/g' /usr/local/apache/conf/httpd.conf
sed -i 's/Group daemon/Group apache/g' /usr/local/apache/conf/httpd.conf

# 添加到系统服务
apachectl -k stop
cp /usr/local/apache/bin/apachectl  /etc/rc.d/init.d/httpd
sed -i '1a # chkconfig: 35 70 70' /etc/rc.d/init.d/httpd
sed -i '2a # description: Apache' /etc/rc.d/init.d/httpd
chkconfig --add httpd

# 创建/var/www/html
mkdir /var/www/
ln -s /usr/local/apache/htdocs /var/www/html

# 启动服务
systemctl start httpd.service

# 开机启动
systemctl enable httpd.service

# 显示版本信息
systemctl status httpd.service
httpd -v

# 退出
exit 0
