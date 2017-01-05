#!/bin/bash
# Title: postgreSQL.sh
# Author: Selphia (sp), admin@factory.moe
# Time: 2017.01.04
# Version:	1.0

# 安装
yum -y install postgresql-server postgresql-devel

# 初始化 postgreSQL
su postgres -c 'initdb /var/lib/pgsql/data/'

# 启动 postgreSQL
systemctl start  postgresql.service

# 设置开机启动 postgreSQL
systemctl enable  postgresql.service

# 显示 postgreSQL 版本
psql -V

# 退出
exit 0
