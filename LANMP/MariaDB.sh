#!/bin/bash
# 文件名: MariaDB.sh
# 描述:  用于CentOS 7 系统使用rpm安装MariaDB
# 版本:  1.0
# 创建时间:  2016年11月28日
# 修订:  none
# 作者:  Selphia (sp), admin@factory.moe

# 变量
mysql='mariadb-10.1.19-rhel-7-x86_64-rpms'
mysql_download='http://downloads.mariadb.com/MariaDB/mariadb-10.1/yum/rhel/mariadb-10.1.19-rhel-7-x86_64-rpms.tar'
# 下载
wget $mysql_download
tar -xvf $mysql.tar
$mysql/setup_repository

# 安装
yum install MariaDB-server -y

# 启动 MariaDB
systemctl start mariadb.service

# 设置开机启动 MariaDB
systemctl enable mariadb.service

# 退出
exit 0
