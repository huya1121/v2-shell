#/bin/bash

ngx_php(){
apt-get update -y && apt-get upgrade -y
apt-get install nginx wget socat php7.0-fpm php7.0-curl php7.0-zip php7.0-mysql php7.0-mbstring php7.0-xml php7.0-gd -y
sed -i "s/\;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/7.0/fpm/php.ini
/etc/init.d/php7.0-fpm restart
}

install_acme(){
if [ ! -d "/root/.acme.sh" ]; then
echo "安装acme.sh"
curl  https://get.acme.sh | sh
echo "alias acme.sh=~/.acme.sh/acme.sh" >> /root/.bashrc
source /root/.bashrc
echo "acme.h 安装完成!"
fi
}
acme_cer(){
echo "生成证书……"
systemctl stop nginx
/root/.acme.sh/acme.sh  --issue -d $domain  --standalone --force
systemctl start nginx
echo "证书生成完成！"
}

v2ray(){
echo "开始安装/更新v2ray"
bash <(curl -L -s https://install.direct/go.sh)
wget -qO  /etc/v2ray/config.json  https://raw.githubusercontent.com/huya1121/v2-shell/master/config.json
systemctl restart v2ray
echo "v2ray 安装完成！"
}

change_v2conf(){
ouid=sed -n '25p' /etc/v2ray/config.json | awk -F'"' '{print $4}'
uid=`cat /proc/sys/kernel/random/uuid`
sed -i "s/$ouid/$uid/g" /etc/v2ray/config.json
echo "UUID=$uid"
}
conf_nginx(){
wget -qO /etc/nginx/sites-available/ https://raw.githubusercontent.com/huya1121/v2-shell/master/v2.conf
ln -s /etc/nginx/sites-available/v2.conf /etc/nginx/sites-enable/
sed 's/$domain/abc.com/g' /etc/nginx/sites-available/v2.conf
/etc/init.d/nginx restart
}



read -p "Please input your domain name:" domain
echo "您输入的域名是：$domian"
ngx_php
install_acme
acme_cer
v2ray
change_v2conf
conf_nginx
echo "服务器: $domain"
echo "端口：443"
echo "UUID：$uid"
echo "PATH：/api/"
echo "WS+TLS"
echo "install complete"
