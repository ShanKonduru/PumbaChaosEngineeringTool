@echo off
docker run -itd --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba -l info --random --interval 30s kill
