yun -y update
yum -y install yum-utils
yum -y groupinstall 'Development Tools'
yum -y install python-setuptools 
easy_install pip

# 新建用户
echo "请输入新用户名:"
read name
adduser $name
# 这里要设置用户密码
passwd $name
usermod -aG wheel $name


# 防止新用户不能使用公钥登陆
su - $name
cd ~
mkdir .ssh
touch ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
exit


# 禁用 root 用户 ssh 登陆
# 默认 'PermitRootLogin yes' 是被注释的，不删除也行
cp /etc/ssh/sshd_config /etc/ssh/sshd_config_old
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
# 更改 ssh 端口
echo "请输入 ssh 端口:"
read port
echo "接下来请手动编辑文件 /etc/ssh/sshd_config，
找到 port 22 改为想要的端口， 输入任意键以继续"
vi /etc/ssh/sshd_config 
firewall-cmd --add-port $port/tcp --permanent
firewall-cmd --add-port $port/tcp
firewall-cmd --reload
systemctl restart sshd 

# 下面使用新账户设置

su - $name

# python 
echo "设置 shadowsocks 密码"
read passwd
echo "设置 shadowsocks 端口"
read port
pip install git+https://github.com/shadowsocks/shadowsocks.git@master
sudo ssserver -p $port -k $passwd -m aes-256-cfb --user nobody -d start

# pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
echo '
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"' >> .bashrc
source .bashrc

pyenv install -l

echo "请选择需要安装的的版本:"
read python_version
pyenv install $python_version

pyenv local $python_version

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

