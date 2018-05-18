# centos7 安装基础软件

# supervisor
pip install supervisor


# redis
# https://redis.io/download
# src/redis-server src/redis-cli
wget http://download.redis.io/releases/redis-4.0.9.tar.gz
tar zxf redis-4.0.9.tar.gz
cd redis-4.0.9
make

# MySQL
# https://dev.mysql.com/doc/refman/8.0/en/linux-installation-yum-repo.html
wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
sudo yum install mysql80-community-release-el7-1.noarch.rpm

# Nginx
wget https://nginx.org/download/nginx-1.14.0.tar.gz
tar zxf nginx-1.14.0.tar.gz
wget https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz
tar zxf pcre-8.41.tar.gz
wget http://zlib.net/zlib-1.2.11.tar.gz
tar zxf zlib-1.2.11.tar.gz
./configure --sbin-path=/usr/local/nginx/nginx --conf-path=/usr/local/nginx/nginx.conf  --pid-path=/usr/local/nginx/nginx.pid --with-http_ssl_module --with-pcre=../pcre-8.41 --with-zlib=../zlib-1.2.11
make
make install

# letsencrypt
# https://certbot.eff.org/lets-encrypt/centosrhel7-nginx
 sudo yum install certbot-nginx
 sudo certbot --nginx

# docker
# https://docs.docker.com/install/linux/docker-ce/centos/
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce
sudo systemctl start docker

