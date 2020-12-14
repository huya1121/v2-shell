### This is a project for v2ray onekey ws+tls
#### Steps:
###### 1.脚本理论上支持Debian9，10（8可能要去掉nginx中http2设置）
###### 2.把域名解析到对应的IP
###### 3. 执行一下命令即可安装完成：
          bash <(curl -L -s https://raw.githubusercontent.com/huya1121/xray/master/xray.sh) install
###### 4.如果需要更新证书，请执行一下命令：
          bash <(curl -L -s https://raw.githubusercontent.com/huya1121/xray/master/xray.sh) renew
