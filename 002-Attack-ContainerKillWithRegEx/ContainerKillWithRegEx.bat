@echo off

REM Create an image using nginx:latest
docker pull nginx

REM Create few Containers starting name shan and some starting new, so that we can run selective Container Kill based on name    
docker run --name shan-nginx1 -v /some/content:/usr/share/nginx/html:ro -d nginx
docker run --name shan-nginx2 -v /some/content:/usr/share/nginx/html:ro -d nginx
docker run --name shan-nginx3 -v /some/content:/usr/share/nginx/html:ro -d nginx
docker run --name shan-nginx4 -v /some/content:/usr/share/nginx/html:ro -d nginx
docker run --name new-nginx1 -v /some/content:/usr/share/nginx/html:ro -d nginx
docker run --name new-nginx2 -v /some/content:/usr/share/nginx/html:ro -d nginx
docker run --name new-nginx3 -v /some/content:/usr/share/nginx/html:ro -d nginx
docker run --name new-nginx4 -v /some/content:/usr/share/nginx/html:ro -d nginx

REM every 10 second  kill containers starting with letter "new"
docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --interval=10s --random --log-level=info kill --signal=SIGKILL "re2:^new"

REM every 30 second  kill containers starting with letter "shan"
REM docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --i=30s --random --l=info kill --signal=SIGKILL "re2:^shan"
