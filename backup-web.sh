#!/bin/bash
# 文件名:  backup-web.sh
# 描述:	备份网站所在文件夹，使用tar压缩并打包
#		备份数据库内容,需要设置要备份的数据库名、MySQL的用户名及密码
# 版本:  2.2
# 创建时间:  2016年12月25日
# 修订:  none
# 作者:  Selphia (sp), admin@factory.moe

#环境变量
html="/var/www/html"	# HTML文件夹
backup=""				# 备份文件目录
sql_name=""				# 备份内数据库名称
sql_user="root"			# Mysql用户名
sql_passwd=""			# Mysql密码

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
tar -Jpcf html_"$time".tar.xz $html

# 备份数据库
mysqldump -u"$sql_user" -p"$sql_passwd" $sql_name > "$sql_name"_"$time".sql

#重新启动系统服务
systemctl restart httpd.service
systemctl restart mariadb.service

#退出
exit 0
