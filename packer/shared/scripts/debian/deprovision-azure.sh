#bin/bash -ex

#https://developer.hashicorp.com/packer/integrations/hashicorp/azure/latest/components/builder/arm#linux

/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync
