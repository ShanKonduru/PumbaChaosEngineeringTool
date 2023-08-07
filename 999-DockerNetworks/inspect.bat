@echo off

REM Get all networks in docker
docker network ls

REM Inspect both Networks
docker inspect network1 network2

REM Get IP address from network1
docker inspect -f '{{range .IPAM.Config}}{{.Subnet}}{{end}}' network1

REM Get IP address from network2
docker inspect -f '{{range .IPAM.Config}}{{.Subnet}}{{end}}' network2

REM  let's list all containers with their identifiers:
docker ps --format 'table {{.ID}}\t{{.Names}}'

REM get IP address of Containers 
docker inspect <ContainerID> --format '{{.NetworkSettings.Networks.network1.IPAddress}}'

REM get IP address of Containers 
docker inspect <ContainerID> --format '{{.NetworkSettings.Networks.network2.IPAddress}}'

REM Alternatively, we can print hosts directly from a container using the docker exec command:
docker exec 78c10f03ad89 cat /etc/hosts


REM Communication Between Containers

REM Launch shell for Test1
docker exec -it test1 /bin/bash

REM you can ping Test2 from Test1 machine 
root@test1:/# curl 172.22.0.2:8080
OR
root@test1:/# curl test2:8080

REM the following command will timeout
root@test1:/# curl 172.23.0.2:8080
OR
root@test1:/# curl test3:8080

REM To make this work, we need to add “test3” container to “network1” (from outside of the container):

docker network connect --alias test3 network1 f229dde68f3b

Now request to “test3” will work correctly:

root@test1:/# curl test3:8080
