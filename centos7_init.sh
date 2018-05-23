yum -y update
yum -y install yum-utils
yum -y install vim
yum -y groupinstall 'Development Tools'
yum -y install python-setuptools 
yum install -y readline readline-devel readline-static 
yum install -y openssl openssl-devel openssl-static
yum install -y sqlite-devel
yum install -y bzip2-devel bzip2-libs
easy_install pip

# 新建用户
read
echo "请输入新用户名:"
read name
adduser $name
# 这里要设置用户密码
passwd $name
usermod -aG wheel $name


# 防止新用户不能使用公钥登陆
# su - jian "git clone https://github.com/jianjian01/script.git && bash script/sub_user.sh" 
# cd ~
# mkdir .ssh
# echo "是否需要上传公钥 Y/N?"
# read anwser
# touch ~/.ssh/authorized_keys
# if [$anwser == "Y"]
# then
#     vim ~/.ssh/authorized_keys
# fi

# chmod 700 ~/.ssh
# chmod 600 ~/.ssh/authorized_keys
# exit' >> temp.sh && bash temp.sh 

# python 
read
echo "设置 shadowsocks 密码"
read passwd
echo "设置 shadowsocks 端口"
read port
pip install git+https://github.com/shadowsocks/shadowsocks.git@master
ssserver -p $port -k $passwd -m aes-256-cfb --user nobody -d start

firewall-cmd --add-port $port/tcp --permanent
firewall-cmd --add-port $port/tcp
firewall-cmd --reload
systemctl restart sshd 


# 禁用 root 用户 ssh 登陆
# 默认 'PermitRootLogin yes' 是被注释的，不删除也行
cp /etc/ssh/sshd_config /etc/ssh/sshd_config_old
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
systemctl restart sshd 

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

su - $name "git clone https://github.com/jianjian01/script.git && bash script/sub_user.sh" 
systemctl restart sshd 
