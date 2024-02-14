#!/bin/bash

# app_list=$(ls | grep -v snap)
app_list="
javaspringvulny
owasp-webgoat-dot-net-docker
railsgoat
vuln_django_play
xss-fastapi
"
for app in $app_list; do 
	cd ~/$app
	docker-compose down
	sleep 5
	docker-compose up -d
done