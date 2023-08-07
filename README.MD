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

### set up Test Data - Setup Containers to be Killed

Use the following command to stop docker containers once in every 10 minutes.
In order to test this command, we must have few containers running in "Docker Desktop".
1. Create 4 or 5 Nginx Containers using the following command.
    Create Container #1
    ```shell
        docker run -l service=nginx -p 80:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        bbba5a85d2e96e2d94263e0886e8578345723cecb0329c45a129a71860a41111
    ```
    Create Container #2
    ```shell
        docker run -l service=nginx -p 81:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        4bf294b5f63d191a8e12c29a03878d63e62ec7c7c49bc070811a5e2b894a83e5
    ```
    Create Container #3
    ```shell
        docker run -l service=nginx -p 82:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        20b8abf8d145cbab134f9cf63f063796456e93230d150a5e5117ba9d68345638
    ```
    Create Container #4
    ```shell
        docker run -l service=nginx -p 83:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        11d3c7d1dbd2381b69845b029015755360fa7282610ecee736cdce9903f7139a
    ```
    Create Container #5
    ```shell
        docker run -l service=nginx -p 84:80 -d nginx
    ```
    After successfull execution of the above command, you would get the Container ID as output shown below.
    ```shell
        4bfe6205999846f11042a3c8ac48e418f8e8985185f8308461d43c58ea02157e
    ```
### Test
### Stady state
2. To see if the containers were created or not use the following command.
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
### Observability/Monitoring
3. If you see the above command it gives an instant status of containers, but while running the experiments on Docker Containers we need to which container is down and which container is up. to do that docker ps might not help, we need to use the following command to constantly monitor docker ps command.
    Open Powershell command window and run the following command. this command runs every 5 seconds and update the docker ps  command output.
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
### Run Attack
4. Use the following command to generate docker container, this container does the job of kiiling all other Docker Containers running at that instance in time.
    ```shell
    docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba -l info --random --interval 30s kill
    ```

## 002-Attack-NetworkDelay

### Add network delay to a Container on userdefined netowrk

### create a docker network.
```shell
docker network create -d bridge --subnet 172.27.0.0/16 shan-nw44-solated
```
### Run a docker container in this network.
```shell
docker run -d -p 4444:4444 -v /dev/shm:/dev/shm --name=shan-container44 --network=shan-nw44-solated --ip=172.27.3.3 selenium/standalone-chrome
```

### get list of  newly created docker containers
```shell
docker container ps
```
```output
CONTAINER ID   IMAGE                        COMMAND                  CREATED          STATUS          PORTS                              NAMES
3bdf8d98f7be   selenium/standalone-chrome   "/opt/bin/entry_poin…"   15 minutes ago   Up 15 minutes   0.0.0.0:4444->4444/tcp, 5900/tcp   shan-container44
```
### Inspect container using the following command
```shell
docker inspect 3bdf8d98f7be
```
```output
[
    {
        "Id": "3bdf8d98f7beddeba219afb4fce12b1472a3c1dd1aa4da4fd27540240e8053b8",
        "Created": "2023-08-07T07:39:16.566449912Z",
        "Path": "/opt/bin/entry_point.sh",
        "Args": [],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 7411,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2023-08-07T07:39:18.69797485Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:0e87ef08c8ea7826615efa7943c4799eebf50d50f8d15864a7291aee186f2571",
        "ResolvConfPath": "/var/lib/docker/containers/3bdf8d98f7beddeba219afb4fce12b1472a3c1dd1aa4da4fd27540240e8053b8/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/3bdf8d98f7beddeba219afb4fce12b1472a3c1dd1aa4da4fd27540240e8053b8/hostname",
        "HostsPath": "/var/lib/docker/containers/3bdf8d98f7beddeba219afb4fce12b1472a3c1dd1aa4da4fd27540240e8053b8/hosts",
        "LogPath": "/var/lib/docker/containers/3bdf8d98f7beddeba219afb4fce12b1472a3c1dd1aa4da4fd27540240e8053b8/3bdf8d98f7beddeba219afb4fce12b1472a3c1dd1aa4da4fd27540240e8053b8-json.log",
        "Name": "/shan-container44",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": [
                "/dev/shm:/dev/shm"
            ],
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "shan-nw44-solated",
            "PortBindings": {
                "4444/tcp": [
                    {
                        "HostIp": "",
                        "HostPort": "4444"
                    }
                ]
            },
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "ConsoleSize": [
                30,
                120
            ],
            "CapAdd": null,
            "CapDrop": null,
            "CgroupnsMode": "host",
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "private",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": [],
            "BlkioDeviceWriteBps": [],
            "BlkioDeviceReadIOps": [],
            "BlkioDeviceWriteIOps": [],
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DeviceRequests": null,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": false,
            "PidsLimit": null,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0,
            "MaskedPaths": [
                "/proc/asound",
                "/proc/acpi",
                "/proc/kcore",
                "/proc/keys",
                "/proc/latency_stats",
                "/proc/timer_list",
                "/proc/timer_stats",
                "/proc/sched_debug",
                "/proc/scsi",
                "/sys/firmware"
            ],
            "ReadonlyPaths": [
                "/proc/bus",
                "/proc/fs",
                "/proc/irq",
                "/proc/sys",
                "/proc/sysrq-trigger"
            ]
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/6745ced4eef74226a794da4f6e400f9139f080d0cd07a6173ff9e8d9e86f1796-init/diff:/var/lib/docker/overlay2/11f8594eadd947c8b7ff778158514faa6d146dcdedd1adabb35eb0997092ab1e/diff:/var/lib/docker/overlay2/316ff8bdf5ebaa0fba02af48f902a996de5dbf9ed080f4c41ca70974a59bf577/diff:/var/lib/docker/overlay2/634d8c1bee0c5a2fd094b92c36e45a5f2b37ae45498156a12cd1414904ecba69/diff:/var/lib/docker/overlay2/9f56f4389f904b4c74bca21a26e0919c799086a1f59556e526991d677ec776fb/diff:/var/lib/docker/overlay2/a3a1d54543ad37c338b4bd33ac86bd7976150a3a0623beefbfa2114b30629693/diff:/var/lib/docker/overlay2/b829c255aed98d5b3d8c157d9a831d129eaf42213fa5b9b2b191c1a90a905039/diff:/var/lib/docker/overlay2/c8585abf62c573d70400b0bd3c7cb23dd3a8c720fce3c1705418c41c9af22b09/diff:/var/lib/docker/overlay2/e876321392b60a89e14de72a59015f4c8eab3eb8d630ea7250c16627defd89cc/diff:/var/lib/docker/overlay2/34b7c5b33cb1a9ee71527d9d0c4dad451ae1659afd46901f6432a44e28f28745/diff:/var/lib/docker/overlay2/18e3ccee533076727713bc428e88052a7adbf72943f723cc1c446db635b4b199/diff:/var/lib/docker/overlay2/35fd3169f7f9a9e4299786cc7246ff4bab3f35b7a0f89cf8f8174d2c6ac2dabe/diff:/var/lib/docker/overlay2/5fee84f8abf68f6bdd03774bce5db6de47a2e398a4195b9feb938021c5bab0c0/diff:/var/lib/docker/overlay2/b7f0249d7e0122bb0fae210196f04aee5ab56abc8a2e4d6617beed23da6917e2/diff:/var/lib/docker/overlay2/44852f3d83d2b3108d3c58fb44e38f5701041a8c101bcf78a869700e4f52e193/diff:/var/lib/docker/overlay2/ce7b3578ab32b1ae7b348d8c8803fa37c0c64da62f40ba19b7bc0ef8d936c064/diff:/var/lib/docker/overlay2/b0f1536a2955c392ea5bf6db0660e1ce76102a328ba06e912346f3fcdda7dc12/diff:/var/lib/docker/overlay2/1c39f83cf1f4fcc7fc842e6bcb993779117fcf62ff3c8aa8ad80651f8efef7f5/diff:/var/lib/docker/overlay2/e581842efd4b1199ea7d62bd093d1c22dc7ed5815e7ac49628378d45d4375240/diff:/var/lib/docker/overlay2/42ce6a7c8886de031a969f0deb141f95627909d62edd0fb9782562b03de9138f/diff:/var/lib/docker/overlay2/73ca2dbb051da41e92f0cd6d3f27be71a90bfd716032d01d2c303e30a37ba0a5/diff:/var/lib/docker/overlay2/bf1ca23b2caf54ce38a756ff5b899ab189028b3631a71198eec2aa8c72e5ba40/diff:/var/lib/docker/overlay2/0222d225ea630114c742ec5e20d4640fda0189a488e9dbea6ce3e487e4102a96/diff:/var/lib/docker/overlay2/966dedb367c7c38de8c0db9e40228b003a028d1d5598b0b78dc4acd9214b2c16/diff:/var/lib/docker/overlay2/15ee68794f9c4d4d4cc9a9ead6ed17dca9581f790815d6d1849374370496e3fb/diff:/var/lib/docker/overlay2/89a90ded265bf66fc0353939f1e905819103edf31b8986b87505b2616a94a76b/diff:/var/lib/docker/overlay2/02da4c992e405fa1c672917938d53d2dee5506be38baf6678b25d68963280d02/diff:/var/lib/docker/overlay2/e76c7ee156e9a35f7a9743c219fe87b7715a93c0e05018a11faeedee6a112197/diff:/var/lib/docker/overlay2/8001cce82a66c34cec992d3405c4c4abdd27a404d6c22f1f8ad93c88d0fda3a1/diff:/var/lib/docker/overlay2/ea44ef653bdc1706773453486ef76c593e90d9ed38352ac2bdd1fb7ca1c7f6cd/diff:/var/lib/docker/overlay2/4a6bc7e77906679f8bd068b00cb9c69165e358e185b8c4173bf7aebcd9b8412e/diff:/var/lib/docker/overlay2/792eff24ebb1be67262b2a7b2f2cf424cb40eb58e1d6ecda3c1e456a3d87d3c1/diff:/var/lib/docker/overlay2/a3ca06b652f8f54dfa761aaeb96073137a14a4b0f5a884f0fba31f574ebe5d12/diff:/var/lib/docker/overlay2/cdc418c08dba22495284558ffe1fb92f279ef0d8dfb92d609416623447b70bcb/diff",
                "MergedDir": "/var/lib/docker/overlay2/6745ced4eef74226a794da4f6e400f9139f080d0cd07a6173ff9e8d9e86f1796/merged",
                "UpperDir": "/var/lib/docker/overlay2/6745ced4eef74226a794da4f6e400f9139f080d0cd07a6173ff9e8d9e86f1796/diff",
                "WorkDir": "/var/lib/docker/overlay2/6745ced4eef74226a794da4f6e400f9139f080d0cd07a6173ff9e8d9e86f1796/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [
            {
                "Type": "bind",
                "Source": "/dev/shm",
                "Destination": "/dev/shm",
                "Mode": "",
                "RW": true,
                "Propagation": "rprivate"
            }
        ],
        "Config": {
            "Hostname": "3bdf8d98f7be",
            "Domainname": "",
            "User": "1200",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "ExposedPorts": {
                "4444/tcp": {},
                "5900/tcp": {}
            },
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
                "DEBIAN_FRONTEND=noninteractive",
                "DEBCONF_NONINTERACTIVE_SEEN=true",
                "TZ=UTC",
                "HOME=/home/seluser",
                "SE_BIND_HOST=false",
                "LANG_WHICH=en",
                "LANG_WHERE=US",
                "ENCODING=UTF-8",
                "LANGUAGE=en_US.UTF-8",
                "LANG=en_US.UTF-8",
                "NOVNC_VERSION=1.4.0",
                "WEBSOCKIFY_VERSION=0.11.0",
                "SE_SCREEN_WIDTH=1360",
                "SE_SCREEN_HEIGHT=1020",
                "SE_SCREEN_DEPTH=24",
                "SE_SCREEN_DPI=96",
                "SE_START_XVFB=true",
                "SE_START_VNC=true",
                "SE_START_NO_VNC=true",
                "SE_NO_VNC_PORT=7900",
                "SE_VNC_PORT=5900",
                "DISPLAY=:99.0",
                "DISPLAY_NUM=99",
                "CONFIG_FILE=/opt/selenium/config.toml",
                "GENERATE_CONFIG=true",
                "SE_DRAIN_AFTER_SESSION_COUNT=0",
                "SE_NODE_MAX_SESSIONS=1",
                "SE_NODE_SESSION_TIMEOUT=300",
                "SE_NODE_OVERRIDE_MAX_SESSIONS=false",
                "DBUS_SESSION_BUS_ADDRESS=/dev/null",
                "SE_RELAX_CHECKS=true"
            ],
            "Cmd": [
                "/opt/bin/entry_point.sh"
            ],
            "Image": "selenium/standalone-chrome",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {
                "authors": "",
                "org.opencontainers.image.ref.name": "ubuntu",
                "org.opencontainers.image.version": "20.04"
            }
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "debda1adc1a8bb31af38d11771e77a504c4c360bfe34ddcb30937ad6b32e3c5c",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {
                "4444/tcp": [
                    {
                        "HostIp": "0.0.0.0",
                        "HostPort": "4444"
                    }
                ],
                "5900/tcp": null
            },
            "SandboxKey": "/var/run/docker/netns/debda1adc1a8",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "",
            "Gateway": "",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "",
            "IPPrefixLen": 0,
            "IPv6Gateway": "",
            "MacAddress": "",
            "Networks": {
                "shan-nw44-solated": {
                    "IPAMConfig": {
                        "IPv4Address": "172.27.3.3"
                    },
                    "Links": null,
                    "Aliases": [
                        "3bdf8d98f7be"
                    ],
                    "NetworkID": "6cb35cd30a9523846fc8cc0c38f4478569b7d3b58b756a5da1fe45134301c0b6",
                    "EndpointID": "2830bfd55ab2d3e72f8b07ccf385fe79e6589a06c41ff2a02b80bb43909fe17a",
                    "Gateway": "172.27.0.1",
                    "IPAddress": "172.27.3.3",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:1b:03:03",
                    "DriverOpts": null
                }
            }
        }
    }
]
```

### inspect newly created docker container with ID and get IP address

```shell
docker inspect -f "{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}" 3bdf8d98f7be 
```
```output
172.27.3.3
```

### check the network interface created, where the docker container is.
```shell
docker network ls
```
```output
NETWORK ID     NAME            DRIVER    SCOPE
be477bea3278   bridge          bridge    local
81de170dc150   host            host      local
4e6ea17464b7   shan-nw44-solated   bridge    local
5d1f4cfddb05   kind            bridge    local
3c937eab1c2d   none            null      local
```

### inspect newly created docker network with ID
```shell
docker inspect 6cb35cd30a95
```
```output
[
    {
        "Name": "shan-nw44-solated",
        "Id": "4e6ea17464b7327b257f1cec34b0c03880405fe7f0fd69bb439662357a3302e9",
        "Created": "2023-08-07T06:49:51.173082637Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.27.0.0/16"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "e91876bf6d977fa532163e6b2b819bad6f575aee5075b89ce33b7462945f7038": {
                "Name": "container44",
                "EndpointID": "e6fadb4009368358c8bad1cc05024dcdedb7a4c4598b8aab601e459778ee5fe2",
                "MacAddress": "02:42:ac:1b:03:03",
                "IPv4Address": "172.27.3.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]
```
### get the ip address used in the netowrk using the following command
```shell
docker inspect -f "{{range .IPAM.Config}}{{.Subnet}}{{end}}" shan-nw44-solated
```
```output
172.27.0.0/16
```
### Now applying netem on the new network
```shell
docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba netem --duration 5m --tc-image gaiadocker/iproute2 delay --time 1000 shan-container44
```
### Use the following command, netem is applying the delay to entire box network
```shell
docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba netem --duration 5m --interface eth0 --tc-image gaiadocker/iproute2 delay --time 1000 shan-container44
```

### Add network delay to a Container

```shell
docker run --rm --name networker -it alpine sh -c "apk add --update iproute2 && ping www.example.com"
```
```shell
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba -l info netem --tc-image=gaiadocker/iproute2 --duration 15s delay --time 5000 networker
```

```shell
docker run --rm --name networker -it alpine sh -c "apk add --update iproute2 && ping www.example.com"
```

```shell
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba -l info netem --duration 120s --tc-image=gaiadocker/iproute2 delay --time 10 networker
```

```shell
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba -l info netem --duration 15s --tc-image=gaiadocker/iproute2 delay --time 5000 networker
```

```shell
docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba -l debug netem --duration 10s --tc-image=gaiadocker/iproute2 loss --percent=100 networker
```

```shell
docker run --rm --name networker -it alpine sh -c "apk add --update iproute2 && apk add --update curl && curl -O https://old-releases.ubuntu.com/releases/18.04.1/ubuntu-18.04.1-live-server-amd64.iso"
```
```shell

docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba netem --duration 2m loss --percent 10 networker
```

## 003-Attack-DropPacket

### every 15 minutes kill `mysql` container and every hour remove containers starting with "shan"

### set up Test Data - Setup Containers to be Killed


```shell
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba -l info --random --interval 30s kill
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba -l info --random --interval 15s kill --signal SIGTERM rm re2:^sh
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
