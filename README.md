## Pi-K8s-Cluster: My Personal Raspberry Pi Cluster

This is an ansible playbook heavily based off of 
[k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible). There were some
issues filed so I basically stole all the roles and then tweaked them as I
needed to.

First run requires `--ask-pass` but subsequent runs should work.

Make sure you don't use this repo as is because then I'll have access to 
all your nodes!  `authorize_github_keys` pulls down the github keys listed
for `github_user`.