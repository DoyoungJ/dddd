#/bin/sh
docker pull nginx:latest
docker run -it --name nginx_webserver -d -p 80:80 nginx