#/bin/bash
depend(){
apt-get update -y && apt-get upgrade -y
apt-get install wget socat curl zip -y
read -p "请输入域名:" domain
echo "您输入的域名是：$domain"
}

ngx(){
apt-get install nginx  -y
systemctl restart nginx || /etc/init.d/nginx restart
}

install_acme(){
if [ ! -d "/root/.acme.sh" ]; then
echo "安装acme.sh"
curl  https://get.acme.sh | sh > /dev/null
echo "alias acme.sh=~/.acme.sh/acme.sh" >> /root/.bashrc
source /root/.bashrc
echo "acme.h 安装完成!"
fi
}

acme_cer(){
echo "生成证书中……"
systemctl stop nginx || /etc/init.d/nginx stop
/root/.acme.sh/acme.sh  --issue -d $domain  --standalone --force
systemctl start nginx || /etc/init.d/nginx start
echo "证书生成完成！"
}

acme_cer_renew(){
read -p "请输入域名:" renewdomain
echo "您输入的域名是：$renewdomain"
echo "生成证书中……"
systemctl stop nginx || /etc/init.d/nginx stop
/root/.acme.sh/acme.sh  --issue -d $renewdomain  --standalone --force
systemctl start nginx || /etc/init.d/nginx start
echo "证书生成完成！"
}

v2ray(){
echo "开始安装/更新v2ray"
bash <(curl -O https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh) > /dev/null
if [ $? == 0 ]; then
echo "v2ray 安装完成！"
else
echo "安装v2ray失败，请检查网络或者重新安装！"
exit 2
fi
}

change_v2conf(){
mkdir -p /usr/local/etc/v2ray/
wget -qO  /usr/local/etc/v2ray/config.json  https://raw.githubusercontent.com/huya1121/v2/master/config.json
ouid=`sed -n '16p' /usr/local/etc/v2ray/config.json | awk -F'"' '{print $4}'`
uid=`cat /proc/sys/kernel/random/uuid`
sed -i "s/$ouid/$uid/g" /usr/local/etc/v2ray/config.json
systemctl restart v2ray
}

conf_nginx(){
wget -qO /etc/nginx/sites-available/v2.conf https://raw.githubusercontent.com/huya1121/v2/master/v2.conf
ln -s /etc/nginx/sites-available/v2.conf /etc/nginx/sites-enabled/v2.conf
sed -i "s/abc.com/$domain/g" /etc/nginx/sites-available/v2.conf
systemctl restart nginx || /etc/init.d/nginx restart
}

v2_info(){
echo "服务器配置信息如下:"
echo "服务器: $domain"
echo "端口：443"
echo "AlterID：64"
echo "UUID：$uid"
echo "PATH：/api/"
echo "WS+TLS"
echo "安装完成"
}

install(){
depend
ngx
install_acme
acme_cer
v2ray
change_v2conf
conf_nginx
v2_info
exit 0
}

#main
case $1 in
  install | start)
  install
  ;;
  renew)
  acme_cer_renew
  ;;
  *)
  echo "please use bash v2ray.sh install or bash v2ray.sh renew"
  ;;
esac

