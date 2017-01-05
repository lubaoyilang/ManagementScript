#!/bin/bash
# 文件名: Apache2.sh
# 描述:  用于CentOS 7 系统编译安装 Apache2 MariaDB Nginx PHP7
# 版本:  1.0
# 创建时间:  2016年11月23日
# 修订:  none
# 作者:  Selphia (sp), admin@factory.moe

# 选择安装哪些程序

echo "选择安装模式："
echo "<1>	[LAMP] Apache2 + MariaDB + PHP7"
echo "<2>	[LNMP] Ngingx + MariaDB + PHP7"
echo "<3>	[LAMP] Apache2 + Nginx + MariaDB + PHP7"

read -s -n1 confirm

if test -z "$confirm"
then
	echo "XXXXXXXXXXXXXXXXXX"
	exit 0
fi

while test -n "$confirm"
do
if [ "$confirm" == '1' ]
then
	echo '即将安装 Apache + MariaDB + PHP7'
	read -s -n1
	break
elif [ "$confirm" == '2' ]
then
	echo '即将安装 Ngingx + MariaDB + PHP7'
	read -s -n1
	break
elif [ "$confirm" == '3' ]
then
	echo '即将安装 Apache + Nginx + MariaDB + PHP7'
	read -s -n1
	break
else
	echo "输入错误请重新选择"
	echo "<1> [LAMP] Apache2 + MariaDB + PHP7"
	echo "<2> [LNMP] Ngingx + MariaDB + PHP7"
	echo "<3> [LAMP] Apache2 + Nginx + MariaDB + PHP7"
	read -s -n1 confirm
fi
echo $confirm
done
exit 0
