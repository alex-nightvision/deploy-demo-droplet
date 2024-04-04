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
	# Check if the application is railsgoat and if so, run rails db:setup
	if [ "$app" == "railsgoat" ]; then
		docker-compose run web rails db:setup
	fi
	docker-compose up -d
done

# single containers
docker rm -f dvna
docker run --name dvna -p 9090:9090 -d appsecco/dvna:sqlite
