@echo off
echo version: '3' > docker-compose.yml
echo services: >> docker-compose.yml

for /L %%i in (91,1,100) do (
    echo   nginx_%%i: >> docker-compose.yml
    echo     image: nginx >> docker-compose.yml
    echo     ports: >> docker-compose.yml
    echo       - "%%i:80" >> docker-compose.yml
    echo     networks: >> docker-compose.yml
    echo       - containers_to_kill_net >> docker-compose.yml
    echo     container_name: nginx_%%i >> docker-compose.yml
)

echo networks: >> docker-compose.yml
echo   containers_to_kill_net: >> docker-compose.yml
echo     driver: bridge >> docker-compose.yml

REM Start the containers
docker-compose up -d
