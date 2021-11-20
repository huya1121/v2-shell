#!/bin/bash
set -x
/usr/local/openvpn_as/scripts/confdba -mk cs.ca_bundle -v "`cat /etc/nginx/ssl/abc.com.cert.pem`"
/usr/local/openvpn_as/scripts/confdba -mk cs.priv_key -v "`cat /etc/nginx/ssl/abc.com.key.pem`"
/usr/local/openvpn_as/scripts/confdba -mk cs.cert -v "`cat cat /etc/nginx/ssl/abc.com.cert.pem`"
/bin/sleep 1
