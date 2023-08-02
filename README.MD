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

# How to Run Pumba?

There are two ways to run Pumba.

First, you can download Pumba application (single binary file) for your OS from the project release page and run pumba --help to see a list of supported commands and options.