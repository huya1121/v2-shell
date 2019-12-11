### This is a project for v2ray onekey ws+tls
#### Steps:
###### 1.脚本理论上支持Debian9，10（8可能要去掉nginx中http2设置）
###### 2.把域名解析到对应的IP
###### 3. 执行一下命令：
          bash <(curl -L -s https://raw.githubusercontent.com/huya1121/v2-shell/master/v2ray.sh) install
###### 4.更新证书：
          bash <(curl -L -s https://raw.githubusercontent.com/huya1121/v2-shell/master/v2ray.sh) renew
