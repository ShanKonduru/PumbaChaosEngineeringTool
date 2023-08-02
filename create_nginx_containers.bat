@echo off
echo version: '3' > docker-compose.yml
echo services: >> docker-compose.yml

for /L %%i in (81,1,90) do (
    echo   nginx_%%i: >> docker-compose.yml
    echo     image: nginx >> docker-compose.yml
    echo     ports: >> docker-compose.yml
    echo       - "%%i:80" >> docker-compose.yml
)

REM You can add more configuration options if needed

REM Start the containers
docker-compose up -d
