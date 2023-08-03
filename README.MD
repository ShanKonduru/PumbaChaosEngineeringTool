![Pumba](https://en.wikipedia.org/wiki/Timon_and_Pumbaa#/media/File:Pumbaa.png)  

# Introduction

Building resilient services is the most effective way to defend against unforeseen failures. By testing for resiliency, teams can identify these failures proactively, before they become apparent to the customers or end users. Intentionally inducing failures during resiliency testing allows you to enforce a robust system-building policy. Resilience, in this context, refers to the system's ability to maintain functionality even if certain components experience failures, often referred to as "ephemerality."

Given the increasing popularity of distributed and microservice architecture, resilience testing has become crucial for applications that must operate continuously (24x7x365). Resilience testing involves deliberately introducing various types of failures at the infrastructure level, such as in virtual machines, networks, containers, and processes, and observing how the system responds to and recovers from these unexpected failures that could occur in a production environment. This approach allows for the simulation of realistic failures, ensuring the creation of highly available and resilient systems.

# What is Pumba?

To begin with, Pumba, also known as Pumbaa, is a supporting character in Disney's animated film, The Lion King. In Swahili, the term "pumbaa" translates to "foolish, silly, weak-minded, careless, negligent." Interestingly, this aligns with the desired behavior of the application I have attempted to develop :-)

Pumba draws inspiration from the widely popular Netflix Chaos Monkey, a resilience testing tool for AWS cloud. However, Pumba adopts a similar approach but focuses on the container level. It connects to the Docker daemon running on either a local or remote machine and introduces a certain degree of chaos, randomly terminating, stopping, and removing running containers.

For a system designed to be resilient, it must be capable of recovering from such failures. Services that have "failed" should be restarted, and lost connections need to be restored. Although it might sound simple, achieving this level of resilience requires a different design for your services. You should bear in mind that a service can fail unexpectedly, for various reasons, or the service it relies on might vanish at any moment, only to reappear later. Expect the unexpected!

# Why to run Pumba?

Failures are inevitable and often occur at the most inconvenient times. If your application lacks the ability to recover from system failures, it can lead to dissatisfied customers and potential loss of business. To ensure your system can handle unexpected failures, it is wise to proactively take charge and deliberately inject failures instead of waiting for them to occur naturally. This proactive approach is not a one-time effort but becomes crucial in the era of Continuous Delivery, where every change to any system service should not compromise system availability. Hence, practicing continuous resilience testing is essential.

With Docker's increasing popularity, people are deploying and running container clusters in production environments. Container orchestration networks like Kubernetes, Swarm, or CoreOS fleet allow automatic restart of "failed" containers. However, the challenge lies in ensuring that the restarted services and other system components can recover effectively from failures. For those not using container orchestration frameworks, handling container restarts becomes even more demanding, as it requires manual intervention.

This is where Pumba comes in as a valuable tool. By running Pumba on each Docker host within your cluster, it enables you to "randomly" stop running containers based on specified names or name patterns. You can even specify the signal that will be sent to "kill" the container, granting you greater control over resilience testing in your environment.

# What Pumba can do?

Pumba offers a variety of ways to induce failures in your active Docker containers. It can perform actions like killing, stopping, or removing running containers. Moreover, Pumba can temporarily pause all processes within a running container for a specified duration. Additionally, Pumba provides network emulation capabilities, allowing you to simulate various network failures, such as delays, packet loss, corruption, reordering, bandwidth limits, and more. However, please note that as of Pumba v0.2.0, the netem command is still in development, and only the delay command is supported.

To specify the target containers for these failure-inducing actions, you have two options. You can either pass a list of containers directly to Pumba or use a regular expression to select containers that match specific criteria. If you don't explicitly specify any containers, Pumba will attempt to disturb all running containers. For random selection from a provided list of target containers, you can utilize the --random option.

# How to Install Pumba?

Pumba can be installed in many ways, in this article we will talk about easiest way to install and start using.

## Download the Binary and Deploy

1. Navigate to the following URL
   ```shell
   https://github.com/alexei-led/pumba/releases
   ```
2. Scroll down to Assets and look for table similar the below.
   ```shell
   pumba_darwin_amd64              14.4 MB             Jan 12
   pumba_darwin_arm64              14 MB               Jan 12
   pumba_linux_amd64               14.6 MB             Jan 12
   pumba_linux_arm64               13.9 MB             Jan 12
   pumba_windows_amd64             15 MB               Jan 12
   Source code                     (zip)               Jan 12
   Source code                     (tar.gz)            Jan 12
   ```
3. Download the file compatible with your Operating System, As i am using Windows Desktop, I am downloading "pumba_windows_amd64"
4. Once downloading is done, rename the file to pumba.exe
5. Copy this file into a folder say C:\chaostools\pumba
6. Update User level Path and System level Path environment variables with this path "C:\chaostools\pumba"
7. To check if the install is done and configured properly, Open command window
   ```shell
   pumba --version
   ```
   The following is the typical output for the above command
   ```shell
   Pumba version 0.9.7 - [0.9.7:03f48c4] 2023-01-12 09:20 UTC
   ```
8. To know the usage of pumba and help type the following command Open command window
   ```shell
   pumba --help
   ```
   The following is the typical output for the above command
   ```shell
   NAME:
       Pumba - Pumba is a resilience testing tool, that helps applications tolerate random Docker container failures: process, network and performance.
   USAGE:
       pumba [global options] command [command options] containers (name, list of names, or RE2 regex if prefixed with "re2:")
   VERSION:
       0.9.7 - [0.9.7:03f48c4] 2023-01-12 09:20 UTC
   AUTHOR:
       Alexei Ledenev <alexei.led@gmail.com>
   COMMANDS:
       kill     kill specified containers
       exec     exec specified containers
       restart  restart specified containers
       stop     stop containers
       pause    pause all processes
       rm       remove containers
       stress   stress test a specified containers
       netem    emulate the properties of wide area networks
       help, h  Shows a list of commands or help for one command
   GLOBAL OPTIONS:
       --host value, -H value       daemon socket to connect to (default: "unix:///var/run/docker.sock") [%DOCKER_HOST%]
       --tls                        use TLS; implied by --tlsverify
       --tlsverify                  use TLS and verify the remote [%DOCKER_TLS_VERIFY%]
       --tlscacert value            trust certs signed only by this CA (default: "/etc/ssl/docker/ca.pem")
       --tlscert value              client certificate for TLS authentication (default: "/etc/ssl/docker/cert.pem")
       --tlskey value               client key for TLS authentication (default: "/etc/ssl/docker/key.pem")
       --log-level value, -l value  set log level (debug, info, warning(*), error, fatal, panic) (default: "warning") [%LOG_LEVEL%]
       --json, -j                   produce log in JSON format: Logstash and Splunk friendly [%LOG_JSON%]
       --slackhook value            web hook url; send Pumba log events to Slack
       --slackchannel value         Slack channel (default #pumba) (default: "#pumba")
       --interval value, -i value   recurrent interval for chaos command; use with optional unit suffix: 'ms/s/m/h' (default: 0s)
       --label value                filter containers by labels, e.g '--label key=value' (multiple labels supported)
       --random, -r                 randomly select single matching container from list of target containers
       --dry-run                    dry run does not create chaos, only logs planned chaos commands [%DRY-RUN%]
       --skip-error                 skip chaos command error and retry to execute the command on next interval tick
       --help, -h                   show help
       --version, -v                print the version
   ```
9. With this Installation and Configuraiton is done

# How to Run Chaos Experiments using Pumba?

## 001-Attack-ContainerKill

### stop docker containers once in every 10 minutes

Use the following command to stop docker containers once in every 10 minutes.
In order to test this command, we must have few containers running in "Docker Desktop".
1. Create 4 or 5 Nginx Containers using the following command.
    * Create Container #1
    ```shell
        docker run -l service=nginx -p 80:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        bbba5a85d2e96e2d94263e0886e8578345723cecb0329c45a129a71860a41111
    ```
    * Create Container #2
    ```shell
        docker run -l service=nginx -p 81:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        4bf294b5f63d191a8e12c29a03878d63e62ec7c7c49bc070811a5e2b894a83e5
    ```
    * Create Container #3
    ```shell
        docker run -l service=nginx -p 82:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        20b8abf8d145cbab134f9cf63f063796456e93230d150a5e5117ba9d68345638
    ```
    * Create Container #4
    ```shell
        docker run -l service=nginx -p 83:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        11d3c7d1dbd2381b69845b029015755360fa7282610ecee736cdce9903f7139a
    ```
    * Create Container #5
    ```shell
        docker run -l service=nginx -p 84:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        4bfe6205999846f11042a3c8ac48e418f8e8985185f8308461d43c58ea02157e
    ```
### Test
2. Stady state - to see if the containers were created or not use the following command.
    ```shell
    docker ps
    ```
    After successfull execution of the above command, you would get the output shown below.
    ```shell
    CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                NAMES
    4bfe62059998   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:84->80/tcp   keen_galileo
    1d3c7d1dbd2   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:83->80/tcp   objective_kalam
    20b8abf8d145   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:82->80/tcp   epic_easley
    4bf294b5f63d   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:81->80/tcp   charming_benz
    bbba5a85d2e9   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:80->80/tcp   romantic_khayyam
    ```
3. Observability  - If you see the above command it gives an instant status of containers, but while running the experiments on Docker Containers we need to which container is down and which container is up. to do that docker ps might not help, we need to use the following command to constantly monitor docker ps command.
    * Open Powershell command window and run the following command. this command runs every 5 seconds and update the docker ps  command output.
    ```shell
    while ($true) { Clear-Host; docker ps; Start-Sleep -Seconds 5 }
    ```
    After successfull execution of the above command, you would get the output shown below and this gets refreshed for evey 5 seconds.
    ```shell
    CONTAINER ID   IMAGE     COMMAND                  CREATED         STATUS         PORTS                NAMES
    4bfe62059998   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:84->80/tcp   keen_galileo
    11d3c7d1dbd2   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:83->80/tcp   objective_kalam
    20b8abf8d145   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:82->80/tcp   epic_easley
    4bf294b5f63d   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:81->80/tcp   charming_benz
    bbba5a85d2e9   nginx     "/docker-entrypoint.…"   4 minutes ago   Up 4 minutes   0.0.0.0:80->80/tcp   romantic_khayyam
    ```
4. Run Attack: Use the following command to generate docker container, this container does the job of kiiling all other Docker Containers running at that instance in time.
    ```shell
    docker run -itd --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba -l info --random --interval 30s kill
    ```

# every 15 minutes kill `mysql` container and

# every hour remove containers starting with "hp"

```shell
pumba --interval 15m kill --signal SIGTERM mysql pumba --interval 1h rm re2:^hp
```

# every 30 seconds kill "worker1" and "worker2" containers

# and every 3 minutes stop "queue" container

```shell
pumba --interval 30s kill --signal SIGKILL worker1 worker2 pumba --interval 3m stop queue
```

# Once in 5 minutes, Pumba will delay for 2 seconds (2000ms)

# egress traffic for some (randomly chosen) container,

# named `result...` (matching `^result` regexp) on `eth2`

# network interface.

# Pumba will restore normal connectivity after 2 minutes.

# Print debug trace to STDOUT too.

```shell
pumba --debug --interval 5m --random netem --duration 2m --interface eth2 delay --amount 2000 re2:^result
```

# Injecting Network Delays

Issue the following command to create a container named networker. This ensures iproute2 is up to date and performs a ping on google.com for testing.

```shell
docker run --rm --name networker -it alpine sh -c "apk add --update iproute2 && ping google.com"
```

```shell
# OUTPUT
fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/main/x86_64/APKINDEX.tar.gz
fetch http://dl-cdn.alpinelinux.org/alpine/v3.8/community/x86_64/APKINDEX.tar.gz
(1/6) Installing libelf (0.8.13-r3)
(2/6) Installing libmnl (1.0.4-r0)
(3/6) Installing jansson (2.11-r0)
(4/6) Installing libnftnl-libs (1.1.1-r0)
(5/6) Installing iptables (1.6.2-r0)
(6/6) Installing iproute2 (4.13.0-r0)
Executing iproute2-4.13.0-r0.post-install
Executing busybox-1.28.4-r1.trigger
OK: 8 MiB in 19 packages
PING google.com (172.217.3.174): 56 data bytes
64 bytes from 172.217.3.174: seq=0 ttl=127 time=8.992 ms
64 bytes from 172.217.3.174: seq=1 ttl=127 time=9.965 ms
64 bytes from 172.217.3.174: seq=2 ttl=127 time=10.332 ms
```

Open a second terminal and issue the following command to cause a 5000 millisecond delay over a total of 15 seconds.

```shell
pumba -l info netem --duration 15s delay --time 5000 networker
```

```shell
# TERMINAL 2: OUTPUT
INFO[0000] Running netem command '[delay 5000ms 10ms 20.00]' on container 2a4066e2865ed24464fa458982374795d62df11b0368e0886f77fc62cdc47664 for 15s  app=pumba function=github.com/alexei-led/pumba/pkg/container.dockerClient.NetemContainer source=container/client.go:220
INFO[0000] start netem for container                     app=pumba dryrun=false function=github.com/alexei-led/pumba/pkg/container.dockerClient.startNetemContainer id=2a4066e2865ed24464fa458982374795d62df11b0368e0886f77fc62cdc47664 iface=eth0 name=/networker netem=delay 5000ms 10ms 20.00 source=container/client.go:276 tcimage=
INFO[0015] stopping netem on container                   IPs=[] app=pumba dryrun=false function=github.com/alexei-led/pumba/pkg/container.dockerClient.StopNetemContainer id=2a4066e2865ed24464fa458982374795d62df11b0368e0886f77fc62cdc47664 iface=eth0 name=/networker source=container/client.go:240 tc-image=
INFO[0015] stop netem for container                      IPs=[] app=pumba dryrun=false function=github.com/alexei-led/pumba/pkg/container.dockerClient.stopNetemContainer id=2a4066e2865ed24464fa458982374795d62df11b0368e0886f77fc62cdc47664 iface=eth0 name=/networker source=container/client.go:298 tcimage=
```

```shell
# TERMINAL 1: OUTPUT
64 bytes from 172.217.3.174: seq=509 ttl=127 time=9.638 ms
64 bytes from 172.217.3.174: seq=512 ttl=127 time=5013.608 ms
64 bytes from 172.217.3.174: seq=514 ttl=127 time=5011.516 ms
64 bytes from 172.217.3.174: seq=510 ttl=127 time=9299.192 ms
64 bytes from 172.217.3.174: seq=511 ttl=127 time=9297.367 ms
64 bytes from 172.217.3.174: seq=516 ttl=127 time=5011.184 ms
64 bytes from 172.217.3.174: seq=513 ttl=127 time=9301.741 ms
64 bytes from 172.217.3.174: seq=518 ttl=127 time=5016.096 ms
64 bytes from 172.217.3.174: seq=519 ttl=127 time=5014.941 ms
64 bytes from 172.217.3.174: seq=515 ttl=127 time=9304.069 ms
64 bytes from 172.217.3.174: seq=527 ttl=127 time=10.468 ms
```

# Dropping Packets

Issue the following command to create a container named networker and have it start downloading a fairly large file via curl.

```shell
docker run --rm --name networker -it alpine sh -c "apk add --update iproute2 && apk add --update curl && curl -O http://ubuntu-releases.eecs.wsu.edu/18.04.1/ubuntu-18.04.1-desktop-amd64.iso"
```

```shell
# TERMINAL 1: OUTPUT
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                Dload  Upload   Total   Spent    Left  Speed
8 1862M    8  155M    0     0  9698k      0  0:03:16  0:00:16  0:03:00 11.4M
```
Open a second terminal and issue the loss command, which will drop 25% of all packets for the next 2 minutes.

```shell
pumba netem --duration 2m loss --percent 10 networker
```
You should notice the packet loss affecting the curl download -- in this case, roughly halving download speeds.

```shell
# TERMINAL 1: OUTPUT
 % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                Dload  Upload   Total   Spent    Left  Speed
13 1862M   13  259M    0     0  7403k      0  0:04:17  0:00:35  0:03:42 5807k
```

# Useful Links

```shell
https://www.gremlin.com/chaos-monkey/chaos-monkey-alternatives/docker/
https://alexei-led.github.io/post/pumba_docker_netem/
```
