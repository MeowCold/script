cd ~
mkdir .ssh
echo "是否需要上传公钥 Y/N?"
read anwser
touch ~/.ssh/authorized_keys
if [$anwser == "Y"];
then
    vim ~/.ssh/authorized_keys
fi

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
exit