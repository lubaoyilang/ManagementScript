#!/b1in/bash
# 文件名: rely.sh
# 描述:  解决编译安装 Apache2 MariaDB Nginx 时，依赖的问题。
# 版本:  1.2
# 创建时间:  2017年1月3日
# 修改时间:  2017年1月4日
# 作者:  Selphia (sp), admin@factory.moe

# 解决依赖
yum -y install gcc gcc-c++
yum -y install wget
yum -y install apr apr-devel
yum -y install apr-util apr-util-devel
yum -y install pcre pcre-devel
yum -y install zlib zlib-devel
yum -y install openssl openssl-devel
yum -y install autoconf automake

# 退出
exit 0
