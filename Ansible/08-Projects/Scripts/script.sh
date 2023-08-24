# This is a script to install python on a target host based on the os distribution.
# You will copy this script using the ansible playbook provided and run it on the target hosts.
#!/bin/bash
declare -A osInfo;
osInfo[/etc/debian_version]="apt"
osInfo[/etc/alpine-release]="apk"
osInfo[/etc/centos-release]="yum"
osInfo[/etc/fedora-release]="dnf"

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        package_manager=${osInfo[$f]}
    fi
done

sudo $package_manager install python3


/*
---
 - name: Install python in target node with ansible
   hosts: 54.67.56.152
   become: true
   gather_facts: no
   tasks:
   - name: Copy script
     copy:
       src: ./script.sh
       dest: .
   - name: install python
     raw: 'cat < /home/ansible/script.sh'
     args:
       executable: /bin/bash

*/
