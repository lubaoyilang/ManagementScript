#!/b1in/bash
# 文件名: install.sh
# 描述:  用于CentOS 7 系统编译安装 Apache2 MariaDB Nginx PHP7
# 版本:  1.0
# 创建时间:  2016年11月30日
# 修订:  none
# 作者:  Selphia (sp), admin@factory.moe

# 选择安装哪些程序
echo -e  "           [ 请选择安装模式 ]           \n"
echo "<1> [LAMP] Apache2 + MariaDB + PHP7"
echo "<2> [LNMP] Ngingx + MariaDB + PHP7"
echo "<3> [LAMP] Apache2 + Nginx + MariaDB + PHP7"

read -s -n1 confirm

# 直接按 Enter键 取消安装
if test -z "$confirm"
then
	echo "取消安装"
	exit 0
fi

# 判断安装方式
while test -n "$confirm"
do
	if [ "$confirm" == '1' ]
	then
		echo '即将安装 Apache + MariaDB + PHP7 , 请按任意键继续。'
		read -s -n1
		break
	elif [ "$confirm" == '2' ]
	then
		echo '即将安装 Ngingx + MariaDB + PHP7 , 请按任意键继续。'
		read -s -n1
		break
	elif [ "$confirm" == '3' ]
	then
		echo '即将安装 Apache + Nginx + MariaDB + PHP7 , 请按任意键继续。'
		read -s -n1
		break
	else
		echo "输入错误请重新选择"
		echo "<1> [LAMP] Apache2 + MariaDB + PHP7"
		echo "<2> [LNMP] Ngingx + MariaDB + PHP7"
		echo "<3> [LAMP] Apache2 + Nginx + MariaDB + PHP7"
		read -s -n1 confirm
	fi
done

# 解决依赖
yum -y install gcc gcc-c++
yum -y install wget
yum -y install apr apr-devel
yum -y install apr-util apr-util-devel
yum -y install pcre pcre-devel
yum -y install zlib zlib-devel
yum -y install openssl openssl-devel
yum -y install autoconf automake

# 开始安装
if [ "$confirm" == '1' ]
then
	# [LAMP] Apache + MariaDB + PHP7
	bash Apache2.sh
	bash MariaDB.sh
	bash PHP7.sh
	break
elif [ "$confirm" == '2' ]
then
	# [LNMP] Ngingx + MariaDB + PHP7
	bash Nginx.sh
	bash Apache2.sh
	bash MariaDB.sh
	break
elif [ "$confirm" == '3' ]
then
	# [LAMP] Apache + Nginx + MariaDB + PHP7
	bash Apache2.sh
	apachectl -k stop
	bash Nginx.sh
	bash MariaDB.sh
	bash PHP7.sh
	break
else
	echo "程序发生了不可遇见的错误，安装失败"
	exit 0
fi

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

if [ "$confirm" == '1' ]
then
	apachectl -k restart
elif [ "$confirm" == '2' ]
then
	nginx -s reload
elif [ "$confirm" == '3' ]
	nginx -s reload
then
else
	echo "程序发生了不可遇见的错误，安装失败"
fi

# 退出
exit 0
