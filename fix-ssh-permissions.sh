#!/usr/bin/env bash
chown -R $USER ~/.ssh
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
chmod 600 ~/.ssh/config
# This unnecessarily closes permissions on .pub keys too, but whatever
chmod 600 ~/.ssh/id_*

ssh-add -d ~/.ssh/id_ed25519
ssh -v boofles.zapto.org
