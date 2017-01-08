#!/bin/bash
# 文件名:  Python3-install.sh
# 描述:  用于CentOS 7 系统编译安装 Python3
# 版本:  3.5.2
# 创建时间:  2016年11月02日
# 修订:  none
# 作者:  Selphia (sp), admin@factory.moe

# 变量
python="Python-3.6.0"
python_down=\
"https://www.python.org/ftp/python/3.6.0/Python-3.6.0.tar.xz"

### 检测是否安装GCC
gcc --version

if [ $? != 0 ]
then
	echo 'Before you proceed, make sure that your system has a C compiler'
	exit 0
fi

# 解决依赖
yum install gcc zlib zlib-devel openssl openssl-devel sqlite-devel bzip2-devel expat-devel gdbm-devel readline-devel -y

# 下载、解压、编译、安装Python
wget $python_down
tar -xvf $python.tar.xz
cd ./$python
./configure --prefix=/usr/bin/Python3
make all
make install

# 设置链接
ln -s /usr/bin/Python3/bin/* /usr/bin

# 更新pip3、安装wheel
pip3 install --upgrade pip
pip3 install wheel

# 结束
python3 -V

# 退出
exit 0
