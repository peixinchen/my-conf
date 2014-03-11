#!/bin/bash

echo && echo "[no-pass-ssh] - make ssh connections without being prompted for password"

myArray=("$@")
REMOTELOGPASS="${myArray[0]}"
RSA_FILE=`echo "$HOME/.ssh/id_rsa"`

if [[ -f $RSA_FILE ]]
then
    echo "[no-pass-ssh]RSA key pairs ($RSA_FILE) existed, using existed key"
else
    read -p "[no-pass-ssh] - press (return) through the prompts to follow:" && echo
    ssh-keygen -t rsa -f $RSA_FILE
fi
echo "[no-pass-ssh] - good; now you will be prompted twice to enter your password:" && echo

cat $RSA_FILE.pub | ssh $REMOTELOGPASS '[ -d .ssh ] || mkdir .ssh; cat >> .ssh/authorized_keys; chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys'

status=$?

if [[ $status -eq 0 ]]
then
    echo && echo "[no-pass-ssh] - try \"ssh {login@hostname}\" now:"
    echo "[no-pass-ssh] - you should no longer be prompted for a password!"
    exit 0
else
    echo "[no-pass-ssh] an error has occured"
    exit 255
fi
