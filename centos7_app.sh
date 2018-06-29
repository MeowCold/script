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
sudo yum localinstall mysql80-community-release-el7-1.noarch.rpm
sudo yum-config-manager --enable mysql80-community
sudo yum install mysql-community-server

# Nginx
sudo yum install epel-release
sudo yum install nginx
sudo systemctl start nginx

# letsencrypt
# https://certbot.eff.org/lets-encrypt/centosrhel7-nginx
 sudo yum install certbot-nginx
 sudo certbot --nginx

# docker
# https://docs.docker.com/install/linux/docker-ce/centos/
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum -y install docker-ce docker-compose
sudo systemctl start docker


# golang
mkdir ~/go
wget https://dl.google.com/go/go1.10.1.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.10.1.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin
export GOPATH=~/go" >> .bashrc
source ~/.bashrc


# zsh
sudo yum -y install zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "source ~/.bashrc" >> ~/.zshrc
