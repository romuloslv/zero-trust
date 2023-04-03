# zero-trust
Manage secrets and ssh logins using: vault, consul, terraform and ansible

<br>

## requirements
In OCI console

* Configure a new bucket

In OCI console user config

* Configure API Keys
* Configure Customer Secret Keys  

In your local environment config

* Configure ~/.oci/config with API Keys  
* Configure modules/templates/credentials with Customer Secret Keys    
* Replace the terraform files that contain "changeme" with your information

<br>

### architecture
https://developer.hashicorp.com/vault/tutorials/day-one-consul/reference-architecture

### consul implantation
https://developer.hashicorp.com/vault/tutorials/day-one-consul/ha-with-consul

### raft implantation
https://developer.hashicorp.com/vault/docs/configuration/storage/raft

### authentication
https://developer.hashicorp.com/vault/docs/auth/oci

### ssh
https://developer.hashicorp.com/vault/docs/secrets/ssh/one-time-ssh-passwords
https://developer.hashicorp.com/vault/docs/secrets/ssh/signed-ssh-certificates
