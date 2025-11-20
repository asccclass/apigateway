#!/usr/bin/sh

cp -f /vagrant/go/src/github.com/asccclass/mcpsrv/data/weather.json /vagrant/go/src/github.com/asccclass/apigateway/data/
curl -sS -X PUT --data-binary '' http://localhost:11018/reload
