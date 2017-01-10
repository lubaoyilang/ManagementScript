#!/bin/bash
# 文件名:  backup-web.sh
# 描述:	备份网站所在文件夹，使用tar压缩并打包
#		备份数据库内容,需要设置要备份的数据库名、MySQL的用户名及密码
# 版本:  2.3
# 创建时间:  2016年12月25日
# 修订:  2017.01.08
# 作者:  Selphia (sp), admin@factory.moe

#环境变量
html_list="/var/www"	# HTML文件夹所在目录
html="html/*"			# HTML文件夹
backup="Backup"			# 备份文件目录
# MariaDB & MySQL
mysql_name=""			# MySQL数据库名称
mysql_user="root"		# Mysql用户名
mysql_passwd=""			# Mysql密码
# postgreSQL
psql_name=""			# PostgreSQL数据库名称
psql_user="postgres"	# PostgreSQL用户名
psql_passwd=""			# PostgreSQL密码

#建立备份目录
test -d $backup
if [ $? != "0" ]
then
	mkdir $backup
fi
cd $backup

# 设置当前日期
time="$(date +%Y%m%d)"

# 备份html文件夹
tar -Jpcf html_"$time".tar.xz -C $html_list $html

# 备份数据库 (请注释掉不使用的数据库)
mysqldump -u"$mysql_user" -p"$mysql_passwd" $mysql_name > "$mysql_name"_"$time".MariaDB
pg_dump -U $psql_user $psql_name > "$psql_name"_"$time".postgreSQL

#重新启动系统服务
systemctl restart httpd.service
systemctl restart mariadb.service
systemctl restart postgresql.service

#退出
exit 0
