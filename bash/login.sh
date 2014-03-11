#!/bin/bash
# ---------------------------------------------------------------------------
# login.sh - login without password

# Copyright 2014, ubuntu64,,, <reedboat@ubuntu>
# All rights reserved.

# Usage: login.sh [-h|--help]

# Revision history:
# 2014-03-11 Created by new_script.sh ver. 3.0
# ---------------------------------------------------------------------------

PROGNAME=${0##*/}
VERSION="0.1"
SSH_LOGIN='./ssh.exp'
PASS_FILE='./etc/.passwd'
g_line=''
g_password=''
user=webroot
port=36000
default_password="first2012++"

find_password() {
    local user=$1
    local ip=$2
    local today=`date +"%Y-%m-%d %H:%M:%S"`

    if [[ $user == 'root' ]]
    then
        g_password=$default_password
        return 0
    else
        g_line=`cat $PASS_FILE|awk -F'\t' '$1 ~"'$ip'" && $4 ~ "'$user'"{print}'|tail -1`
        if [[ ! -z $g_line ]]
        then
	    g_password=`echo $g_line|awk '{print $5}'`
            return 0
        fi
    fi
    return 1
}

clean_up() { # Perform pre-exit housekeeping
    return
}

error_exit() {
    echo -e "${PROGNAME}: ${1:-"Unknown Error"}" >&2
    clean_up
    exit 1
}

graceful_exit() {
    clean_up
    exit
}

signal_exit() { # Handle trapped signals
    case $1 in
        INT)    error_exit "Program interrupted by user" ;;
        TERM)   echo -e "\n$PROGNAME: Program terminated" >&2 ; graceful_exit ;;
        *)      error_exit "$PROGNAME: Terminating on unknown signal" ;;
    esac
}

usage() {
    echo -e "Usage: $PROGNAME [-h|--help] [-r] [-s] [-d] <ip>"
}

help_message() {
	cat <<- _EOF_
	$PROGNAME ver. $VERSION
	login without password

	$(usage)

	Options:
	-h, --help	Display this help message and exit.

	_EOF_
	return
}

# Trap signals
trap "signal_exit TERM" TERM HUP
trap "signal_exit INT"  INT


user=webroot
port=36000

# Parse command-line
while [[ -n $1 ]]; do
	case $1 in
		-h | --help)	help_message; graceful_exit ;;
        -r | --webroot) user=webroot ;;
        -d | --webdev) user=webdev ;;
        -s | --root)   user=root  ;;
		-* | --*)	usage; error_exit "Unknown option $1" ;;
		*)		ip=$1;;
	esac
	shift
done

if [[ -z "$ip" ]]
then
	usage
	exit 2
fi

# Main logic

find_password $user $ip
status=$?

if [[ $status -eq 0 ]]
then
    password=$g_password
    $SSH_LOGIN $ip $user "$password" $port
fi


graceful_exit

