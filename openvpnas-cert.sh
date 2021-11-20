#!/bin/bash
set -x
/usr/local/openvpn_as/scripts/confdba -mk cs.ca_bundle -v "`cat /etc/nginx/ssl/$domain.cert.pem`"
/usr/local/openvpn_as/scripts/confdba -mk cs.priv_key -v "`cat /etc/nginx/ssl/$domain.key.pem`"
/usr/local/openvpn_as/scripts/confdba -mk cs.cert -v "`cat cat /etc/nginx/ssl/$domain.cert.pem`"
/bin/sleep 1
