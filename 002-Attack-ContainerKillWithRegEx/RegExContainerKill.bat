REM Generate 10 Docker alpine containers  named test_(index)
FOR /L %%G IN (1,1,10) DO docker run -d --name test_%%G --rm alpine tail -f /dev/null; done

REM once in 10 seconds, try to kill (with `SIGKILL` signal) all containers named **test(something)**
REM on same Docker host, where Pumba container is running
REM docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --interval=10s --random --log-level=info kill --signal=SIGKILL "re2:^test"