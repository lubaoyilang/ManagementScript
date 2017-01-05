#!/bin/bash
# 文件名: Apache2.sh
# 描述:  用于CentOS 7 系统编译安装 Apache2
# 版本:  2.0
# 创建时间:  2016年11月17日
# 修订:  none
# 作者:  Selphia (sp), admin@factory.moe

# 变量
apache_download='http://mirrors.hust.edu.cn/apache//httpd/httpd-2.4.23.tar.bz2'
apache="httpd-2.4.23"

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
	--with-zlib \
	--with-pcre \
	--enable-modules=all

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

# 设置开机启动
echo "apachectl start" >> /etc/rc.d/rc.local
chmod a+x /etc/rc.d/rc.local
