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

# 设置MariaDB密码
echo "接下来将执行MySQL安全配置向导"
echo "- 输入当前的root密码 (按Enter跳过)"
echo "- 设置root密码"
echo "- 删除匿名帐号"
echo "- 禁止root用户远程登录"
echo "- 删除测试数据库并禁止访问"
echo "- 重新加载权限表"
read -s -n1 -p "按任意键继续 ... "
mysql_secure_installation

# 重启 httpd MariaDB
systemctl restart mariadb.service

# 显示版本信息
systemctl status mariadb.service
mysql -V

# 退出
exit 0
