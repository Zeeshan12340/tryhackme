login page on port 81

limited upload page on port 82

there are users bobba, yoda and duku

upload php_rev_shell as gif and intercept with burpsuite and change extension to .php
run with listener to get shell.
change id_rsa and id_rsa.pub with keys generated with ssh-keygen(use passphrase) \\also authorized keys is same as id_rsa.pub

ssh with id_rsa and passphrase
cd into tmp

tmux -S default attach -t default
