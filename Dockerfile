# nginx최신 stable 버전 컨테이너를 커스텀
FROM nginx:latest
 

# nginx 기동
RUN service nginx start
 
# 포트는 80
EXPOSE 80