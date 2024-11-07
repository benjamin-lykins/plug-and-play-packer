
# Purpose

Purpose of this folder are any resource which are shareable on the packer template. 

## Contents

- Bootstrap

For anything that needs to be bootstrapped on the image before SSH or WinRM access. 
_Think setting up WinRM on Windows images in AWS._

- Files

Any templatized config file will go in here and can be consumed by the files provisioner. 

- Playbooks

Possible play with Ansible here, I generally look at just using bash or powershell scripts, but a lot of organizations have technical debt/hours with Ansible and gives the ability to leverage existing playbooks. 

- Scripts

Any scripts which are reusable in Packer builds will go in here. 