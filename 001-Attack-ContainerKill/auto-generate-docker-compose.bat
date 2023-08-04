@echo off
REM This batch file automatically generate Docker compose file with 10 Nginx containers with port mapping. 
REM Use this batch file to genrate multiple containers to be kiiled using  Pumba's Container Kill experiment  
echo version: '3' > docker-compose.yml
echo services: >> docker-compose.yml

for /L %%i in (1,1,10) do (
    echo   shan-nginx_%%i: >> docker-compose.yml
    echo     image: nginx >> docker-compose.yml
    echo     ports: >> docker-compose.yml
    echo       - "%%i:80" >> docker-compose.yml
    echo     container_name: shan-nginx_%%i >> docker-compose.yml
)

REM Start the containers
docker-compose up -d
