#!/usr/bin/env bash
#
# Ssh has very particular requirements for ownership and permissions,
# and tends to fail silently if they're wrong.  This sets permissions
# on the directory and files so ssh is satisfied.
#
chown -R $USER ~/.ssh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/config
# This unnecessarily closes permissions on .pub keys too, but whatever
chmod 600 ~/.ssh/id_*

ssh-add -d ~/.ssh/id_ed25519
