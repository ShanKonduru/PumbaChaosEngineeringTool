# terraform

## Download and Install terraform
Download the latest ZIP from https://developer.hashicorp.com/terraform/downloads
Extract ZIP into C:\chaostools\terraform
Add this path to both user level and system level Path environment variable
To test Terraform is instlaled or not, use the following command from command window

### check if Terraform installed 
```shell
terraform
```
```output
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
init          Prepare your working directory for other commands
validate      Check whether the configuration is valid
plan          Show changes required by the current configuration
apply         Create or update infrastructure
destroy       Destroy previously-created infrastructure

All other commands:
console       Try Terraform expressions at an interactive command prompt
fmt           Reformat your configuration in the standard style
force-unlock  Release a stuck lock on the current workspace
get           Install or upgrade remote Terraform modules
graph         Generate a Graphviz graph of the steps in an operation
import        Associate existing infrastructure with a Terraform resource
login         Obtain and save credentials for a remote host
logout        Remove locally-stored credentials for a remote host
metadata      Metadata related commands
output        Show output values from your root module
providers     Show the providers required for this configuration
refresh       Update the state to match remote systems
show          Show the current state or a saved plan
state         Advanced state management
taint         Mark a resource instance as not fully functional
test          Experimental support for module integration testing
untaint       Remove the 'tainted' state from a resource instance
version       Show the current Terraform version
workspace     Workspace management

Global options (use these before the subcommand, if any):
-chdir=DIR    Switch to a different working directory before executing the
given subcommand.
-help         Show this help output, or the help for a specified subcommand.
-version      An alias for the "version" subcommand.
```
### get Terraform command help 
```shell
terraform -help
```
```output
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
init          Prepare your working directory for other commands
validate      Check whether the configuration is valid
plan          Show changes required by the current configuration
apply         Create or update infrastructure
destroy       Destroy previously-created infrastructure

All other commands:
console       Try Terraform expressions at an interactive command prompt
fmt           Reformat your configuration in the standard style
force-unlock  Release a stuck lock on the current workspace
get           Install or upgrade remote Terraform modules
graph         Generate a Graphviz graph of the steps in an operation
import        Associate existing infrastructure with a Terraform resource
login         Obtain and save credentials for a remote host
logout        Remove locally-stored credentials for a remote host
metadata      Metadata related commands
output        Show output values from your root module
providers     Show the providers required for this configuration
refresh       Update the state to match remote systems
show          Show the current state or a saved plan
state         Advanced state management
taint         Mark a resource instance as not fully functional
test          Experimental support for module integration testing
untaint       Remove the 'tainted' state from a resource instance
version       Show the current Terraform version
workspace     Workspace management

Global options (use these before the subcommand, if any):
-chdir=DIR    Switch to a different working directory before executing the
given subcommand.
-help         Show this help output, or the help for a specified subcommand.
-version      An alias for the "version" subcommand.
```
### get Terraform version 
```shell
terraform -version
```
```output
Terraform v1.5.4
on windows_amd64
```

## Build Infrastructure - Terraform Docker Example

### Initailize Terraform 
```shell
terraform init
```
```output
Initializing the backend...

Initializing provider plugins...
- Finding kreuzwerker/docker versions matching "~> 3.0.1"...
- Installing kreuzwerker/docker v3.0.2...
- Installed kreuzwerker/docker v3.0.2 (self-signed, key ID BD080C4571C6104C)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```
### Format and validate the configuration
```shell
terraform fmt
```

```shell
terraform validate
```
```output
Success! The configuration is valid.
```

### Create infrastructure
```shell
terraform apply
```
```output
docker_image.nginx: Refreshing state... [id=sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287nginx:latest]
docker_container.nginx: Refreshing state... [id=5ee79e6dc66383e643fb7ec7dd67235c1b7d90ee161ee1001b33d00b1f18a34c]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have
affected this plan:

# docker_image.nginx has been deleted
- resource "docker_image" "nginx" {
id           = "sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287nginx:latest"
- image_id     = "sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287" -> null
name         = "nginx:latest"
# (2 unchanged attributes hidden)
}


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes,
the following plan may include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
+ create

Terraform will perform the following actions:

# docker_container.nginx will be created
+ resource "docker_container" "nginx" {
+ attach                                      = false
+ bridge                                      = (known after apply)
+ command                                     = (known after apply)
+ container_logs                              = (known after apply)
+ container_read_refresh_timeout_milliseconds = 15000
+ entrypoint                                  = (known after apply)
+ env                                         = (known after apply)
+ exit_code                                   = (known after apply)
+ hostname                                    = (known after apply)
+ id                                          = (known after apply)
+ image                                       = (known after apply)
+ init                                        = (known after apply)
+ ipc_mode                                    = (known after apply)
+ log_driver                                  = (known after apply)
+ logs                                        = false
+ must_run                                    = true
+ name                                        = "terraform-container"
+ network_data                                = (known after apply)
+ read_only                                   = false
+ remove_volumes                              = true
+ restart                                     = "no"
+ rm                                          = false
+ runtime                                     = (known after apply)
+ security_opts                               = (known after apply)
+ shm_size                                    = (known after apply)
+ start                                       = true
+ stdin_open                                  = false
+ stop_signal                                 = (known after apply)
+ stop_timeout                                = (known after apply)
+ tty                                         = false
+ wait                                        = false
+ wait_timeout                                = 60

+ ports {
+ external = 8000
+ internal = 80
+ ip       = "0.0.0.0"
+ protocol = "tcp"
}
}

# docker_image.nginx will be created
+ resource "docker_image" "nginx" {
+ id           = (known after apply)
+ image_id     = (known after apply)
+ keep_locally = false
+ name         = "nginx:latest"
+ repo_digest  = (known after apply)
}

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
Terraform will perform the actions described above.
Only 'yes' will be accepted to approve.

Enter a value: yes

docker_image.nginx: Creating...
docker_image.nginx: Still creating... [10s elapsed]
docker_image.nginx: Still creating... [20s elapsed]
docker_image.nginx: Creation complete after 25s [id=sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287nginx:latest]
docker_container.nginx: Creating...
docker_container.nginx: Still creating... [10s elapsed]
docker_container.nginx: Creation complete after 18s [id=b468bc46b8c0e7e5cc404abdfc93f0d22a0185c03dcc50dd7de3144a494f6afc]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```
### Testing the Infrastructure
You have now created infrastructure using Terraform! Visit localhost:8000 in your web browser to verify the container started.
```shell
http://localhost:8000/
```
```output
Welcome to nginx!
If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

For online documentation and support please refer to nginx.org.
Commercial support is available at nginx.com.

Thank you for using nginx.
```
### Inspect state
```shell
terraform show
```
```output
# docker_container.nginx:
resource "docker_container" "nginx" {
attach                                      = false
command                                     = [
"nginx",
"-g",
"daemon off;",
]
container_read_refresh_timeout_milliseconds = 15000
cpu_shares                                  = 0
dns                                         = []
dns_opts                                    = []
dns_search                                  = []
entrypoint                                  = [
"/docker-entrypoint.sh",
]
env                                         = []
group_add                                   = []
hostname                                    = "b468bc46b8c0"
id                                          = "b468bc46b8c0e7e5cc404abdfc93f0d22a0185c03dcc50dd7de3144a494f6afc"
image                                       = "sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287"
init                                        = false
ipc_mode                                    = "private"
log_driver                                  = "json-file"
log_opts                                    = {}
logs                                        = false
max_retry_count                             = 0
memory                                      = 0
memory_swap                                 = 0
must_run                                    = true
name                                        = "terraform-container"
network_data                                = [
{
gateway                   = "172.17.0.1"
global_ipv6_address       = ""
global_ipv6_prefix_length = 0
ip_address                = "172.17.0.2"
ip_prefix_length          = 16
ipv6_gateway              = ""
mac_address               = "02:42:ac:11:00:02"
network_name              = "bridge"
},
]
network_mode                                = "default"
privileged                                  = false
publish_all_ports                           = false
read_only                                   = false
remove_volumes                              = true
restart                                     = "no"
rm                                          = false
runtime                                     = "runc"
security_opts                               = []
shm_size                                    = 64
start                                       = true
stdin_open                                  = false
stop_signal                                 = "SIGQUIT"
stop_timeout                                = 0
storage_opts                                = {}
sysctls                                     = {}
tmpfs                                       = {}
tty                                         = false
wait                                        = false
wait_timeout                                = 60

ports {
external = 8000
internal = 80
ip       = "0.0.0.0"
protocol = "tcp"
}
}

# docker_image.nginx:
resource "docker_image" "nginx" {
id           = "sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287nginx:latest"
image_id     = "sha256:89da1fb6dcb964dd35c3f41b7b93ffc35eaf20bc61f2e1335fea710a18424287"
keep_locally = false
name         = "nginx:latest"
repo_digest  = "nginx@sha256:67f9a4f10d147a6e04629340e6493c9703300ca23a2f7f3aa56fe615d75d31ca"
}
```
### Manually Managing State
``` shell
terraform state list
```
```output
docker_container.nginx
docker_image.nginx
```

