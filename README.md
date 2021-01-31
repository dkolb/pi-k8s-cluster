# Pi-K8s-Cluster: My Personal Raspberry Pi Cluster

## `ansible/`
This is an ansible playbook that reuses 
[k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible) while adding some
of my own stuff for maintianing the nodes.

First run requires `--ask-pass` but subsequent runs should work.

Make sure you don't use this repo as is because then I'll have access to 
all your nodes!  `authorize_github_keys` pulls down the github keys listed
for `github_user`.

## `setup/`
Bootstrapping scripts go here.  To be run after the ansible playbook is
successfully applied.

## `deployments/`

This is where flux looks for stuff to install.
