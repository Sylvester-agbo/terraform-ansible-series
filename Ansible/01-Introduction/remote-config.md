1. Copy the authorized keys from the home of ubuntu to the home of ansible
- Log in as ansible and run the following command
     sudo cp /home/ubuntu/.ssh/authorized_keys .
- Change ownership of the key to ansible
     sudo chown ansible:ansible authorized_keys
2. 