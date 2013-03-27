#!/bin/bash
## ---------------------------------------------------------
## common functions
## author:   samli AT tencent.com | huanlf AT gmail.com
## last mod: 2012-12-21
## ---------------------------------------------------------






## ---------------- classical usage ------------------------
## to source this lib, copy the following lines to your main.sh
## . "$( dirname $0 )/cbl.sh" || exit 1
## cd "$WORKDIR" || exit 1
## ---------------------------------------------------------






## set -x     ## to debug
## set -e     ## Sorry, can not set -e here, fix later

## -------------------- GLOBAL VAR -------------------------

## some vars initialized in the end of this file, check it

## make sure we will find commands needed
export PATH=$PATH:/usr/bin:/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin

## just a var to keep the val from get_localip
## use a strange var name to avoid collision
export LLLOCALIP

## the dir we are working in
export WORKDIR

## some addictional logs may redirected to here
## such as: make >> $LLLOG && make install >> $LLLOG
## use a strange var name to avoid collision
export LLLOG
export LLLOGDIR

## set locale as POSIX, to work around with i180-ed apps
export LANG=C
export LC_ALL=C

## set umask to 022 to avoid wrong access mode
umask 022

## ---------------------------------------------------------






## -------------------- colourful print --------------------

## ANSI Foreground color codes:
## 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white 39=default
## ANSI Background color codes:
## 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white 49=default

COLOR_RED=$(    echo -e "\e[31;49m" ) 
COLOR_GREEN=$(  echo -e "\e[32;49m" )
COLOR_YELLO=$(  echo -e "\e[33;49m" )
COLOR_BLUE=$(   echo -e "\e[34;49m" )
COLOR_MAGENTA=$(echo -e "\e[35;49m" )
COLOR_CYAN=$(   echo -e "\e[36;49m" )
COLOR_RESET=$(  echo -e "\e[0m"     )

## msg argv: "$str"
msg()  { gmsg "$@";                               }     # green
rmsg() { echo "${COLOR_RED}$*${COLOR_RESET}";     }     # red
gmsg() { echo "${COLOR_GREEN}$*${COLOR_RESET}";   }     # green
ymsg() { echo "${COLOR_YELLO}$*${COLOR_RESET}";   }     # yellow
bmsg() { echo "${COLOR_BLUE}$*${COLOR_RESET}";    }     # blue
mmsg() { echo "${COLOR_MAGENTA}$*${COLOR_RESET}"; }     # magenta
cmsg() { echo "${COLOR_CYAN}$*${COLOR_RESET}";    }     # cyan

# colourful print without "\n"
msg_()  {  msg "$@" | tr -d '\n'; }
rmsg_() { rmsg "$@" | tr -d '\n'; }
gmsg_() { gmsg "$@" | tr -d '\n'; }
ymsg_() { ymsg "$@" | tr -d '\n'; }
bmsg_() { bmsg "$@" | tr -d '\n'; }
mmsg_() { mmsg "$@" | tr -d '\n'; }
cmsg_() { cmsg "$@" | tr -d '\n'; }

## normal message print and log
logmsg()
{
    local t=$( date '+%F %T' )

    gmsg "[$t $LLLOCALIP]: $*"

    ## no color in logs
    mkdir -p "$LLLOGDIR" || { rmsg "can not create $LLLOGDIR"; exit 1; }
    echo "[$t $ip]: $*" >> "$LLLOG"
}

## normal message print and log, without "\n"
logmsg_()
{
    local t=$( date '+%F %T' )

    gmsg_ "[$t $LLLOCALIP]: $*"

    ## no color in logs
    mkdir -p "$LLLOGDIR" || { rmsg "can not create $LLLOGDIR"; exit 1; }
    echo -n "[$t $ip]: $*" >> "$LLLOG"
}

## warning
warn()
{
    local t=$( date '+%F %T' )

    ## write to STDERR
    mmsg "[$t $LLLOCALIP]WARNING: $*" >&2

    mkdir -p "$LLLOGDIR" || { rmsg "can not create $LLLOGDIR"; exit 1; }
    echo "[$t $ip]WARNING: $*" >> "$LLLOG"
}

## fatal, will exit with code 1
die()
{
    local t=$( date '+%F %T' )

    ## write to STDERR
    rmsg "[$t $LLLOCALIP]FATAL: $*" >&2

    mkdir -p "$WORKDIR/log.d" || { rmsg "can not create $WORKDIR/log.d"; exit 1; }
    echo "[$t $ip]FATAL: $*" >> "$LLLOG"

    exit 1
}

## ---------------------------------------------------------






## ---------------------- IP / NIC  ------------------------

## get all interfaces ip addr, but default lo
get_ipaddr()
{
    local ipall=$(
        /sbin/ifconfig | 
          awk '/inet addr:/ { if ($2 !~ /127.0.0.1/) { print substr($2,6)} } '
    )

    ipall=$( echo $ipall )  ## trim spaces, blank charachers
    
    if [[ -n $ipall ]]; then
        echo $ipall
    else
        return 1
    fi
}

## get all lan ipaddr. not strict
get_localip_all()
{
    local ip ipall

    for ip in $( get_ipaddr ); do
       case $ip in
           172.*|192.*|10.*)
               ## should deal with the newline symbol '\n' by yourself
               ipall="$ipall $ip"
               ;;
       esac
    done

    ipall=$( echo $ipall )  ## trim spaces, blank charachers

    if [[ -n $ipall ]]; then
        echo $ipall
    else
        return 1
    fi
}

## get all wan ipaddr
get_wanip_all()
{
    local iface ip ipall
    for iface in $(get_wan_iface); do
        ip=$( get_ip_for_interface "$iface" )
        ipall="$ipall $ip"
    done

    if [[ -n $ipall ]]; then
        echo $ipall
    else
        return 1
    fi
}

## get login ip from ssh env val, useful if we have mutilple NICs
## this func is not very reliable, use get_localip instead
get_loginip()
{
    local ip

    for ip in $( echo $SSH2_CLIENT    | awk '{ print $3 }' ) \
              $( echo $SSH_CONNECTION | awk '{ print $3 }' ) \
              $( echo $SSH_CLIENT     | awk '{ print $1 }' ) ; do
        if [[ -n $ip ]]; then  ## never failed ?
            echo $ip
            return 0
        fi
    done

    return 1
}

## get a lan ipaddr, must be an private IP, the ip we login is prefered
get_localip()
{
    ## to speed up, this func may be called frequently
    ## maybe we should use $LLLOCALIP directlly instead of callin get_localip
    [[ -n "$LLLOCALIP" ]] && { echo $LLLOCALIP;  return 0; }

    local default_ip=127.0.0.1  ## make sure we return an "IP"
    local ipall=$( get_localip_all )
    local ip

    for ip in $( get_loginip ) $ipall; do
       case $ip in      ## check if a private IP, need more strict checking ?
           172.*|192.*|10.*)
                # make sure we find the ip on local host
                # result from get_login may not correct
                # note that we do not get '127.0.0.1' from get_localip_all
                if echo $ipall | grep -wq $ip; then
                    LLLOCALIP=$ip 
                    break
                fi
            ;;
        esac
    done

    if [[ -n "$LLLOCALIP" ]]; then
        echo $LLLOCALIP
        return 0
    else
        echo $default_ip
        return 1
    fi
}

## return the the ip on the given interface
## argv: $interface
## example: get_ip_for_interface "eth0"
get_ip_for_interface()
{
    local iface=$1

    ## /sbin/ifconfig "$iface" 2>/dev/null |
    /sbin/ifconfig "$iface" |
       awk '/inet addr:/ { print substr($2,6) } '

    # return the status of ifconfig
    return ${PIPESTATUS[0]}
}

## include sub interface's ip
get_all_ip_for_interface()
{
    local iface=$1
    local ipall=$( 
        {   
            ## physical interface
            /sbin/ifconfig | grep -A1 -E "^$iface[[:space:]]+"
            ## sub interface, such as eth0:0
            /sbin/ifconfig | grep -A1 -E "^$iface:[0-9]+[[:space:]]+"
        } |
        awk '/inet addr:/ { print substr($2,6) } '
    )

    ipall=$( echo $ipall )  ## trim spaces, blank charachers

    if [[ -n $ipall ]]; then
        echo $ipall
    else
        return 1
    fi
}


## return the netmask for an interface
## argv: $interface
## example: get_netmask_for_interface "eth0"
get_netmask_for_interface()
{
    local iface=$1
    [[ -n $iface ]] || return 1

    /sbin/ifconfig "$iface" | awk -F: '/Mask:/ { print $NF }'

    ## return the status of ifconfig
    return ${PIPESTATUS[0]}
}

## 2009-01-12, get mtu for an interface
## argv: $interface
## example: get_mtu_for_interface "eth0"
get_mtu_for_interface()
{
    local iface=$1
    ## mtu on the sub ifc is the same with the physical ifc
    ## local iface=${1%%:*}

    /sbin/ifconfig "$iface" | 
      awk '/MTU:/ {
      if ( $3 ~ /RUNNING/ ) {
          print substr($5,5)
      }
      else {
          print substr($4,5)
      }  }'

    ## return the status of ifconfig
    return ${PIPESTATUS[0]}
}

## 2010-11-01, get mac address ro an interface
## argv: $interface
get_mac_for_interface()
{
    local iface=$1
    [[ -z $iface ]] && return 1

    /sbin/ifconfig "$iface" |  awk '/HWaddr/ { print $NF }'  
}
## return the interface name having the "$ip"
## maybe a sub interface or a real physical interface
get_interface_by_ip()
{
    local ip=$1
    local realifc=$2

    local ifc

    if [[ -z $realifc ]]; then
        ifc=$(
            /sbin/ifconfig | grep -B1 -w "$ip" |
            awk ' NR == 1 { print $1 } ' 
        )
    else
        ifc=$( 
            /sbin/ifconfig | grep -A1 -w "$realifc" | grep -B1 -w "$ip" |
            awk ' NR == 1 { print $1 } ' 
        )
    fi

    if [[ -n $ifc ]]; then
        echo $ifc
    else
        return 1
    fi
}

## return a real physical interface even if the ip is on a sub interface
get_real_interface_by_ip()
{
    local ip=$1
    local r_ifc

    r_ifc=$( get_interface_by_ip "$ip" | sed 's/:[0-9]\+//' )

    if [[ -n $r_ifc ]]; then
        echo $r_ifc
    else
        return 1
    fi
}

## return the interface with local ip
get_local_iface()
{
    local ip
    local ifcall=$( 
        for ip in $( get_localip_all ); do
            get_interface_by_ip "$ip"
        done
    )

    if [[ -n $ifcall ]]; then
        echo $ifcall
    else
        return 1
    fi
}

## return the interface with wan ip, actually, with not lan ip
get_wan_iface()
{
    local wanall
    local localif="/tmp/.localiface"
    local allif="/tmp/.alliface"

    ## one interface per line
    get_local_iface | xargs -n1 > "$localif"

    /sbin/ifconfig | grep -B1 'addr:[0-9]' |
      awk '/^(eth|wlan|ppp)/ { print $1 }' > "$allif"

    wanall=$( grep -xvf "$localif" "$allif" )
    ## /bin/rm "$localif" "$allif"

    if [[ -n $wanall ]]; then
        echo $wanall
    else
        return 1
    fi
}

## return physical iface with local ip
get_real_local_iface()
{
    get_local_iface | xargs -n1 | sed 's/:.*//' | sort -u
}

## return physical iface with wan ip
get_real_wan_iface()
{
    get_wan_iface   | xargs -n1 | sed 's/:.*//' | sort -u
}

## return the interface without a ip configured on it
get_free_iface()
{
    local ifcall=$(
        /sbin/ifconfig -a |
          grep -w 'BROADCAST' -B1 |
          awk '/^[a-z\.]+/ { print $1 }'
    )

    if [[ -n $ifcall ]]; then
        echo $ifcall
    else
        return 1
    fi
}

## if we have eth0, this fun may return eth0:0
## if we have eth:0, may return eth0:1 ....
get_a_free_subname_on()
{
    local iface=$1
    local i=0
    local ip=
    
    while (( i < 255 )); do
        ip=$( get_ip_for_interface "${iface}:$i" )
        if [[ -z $ip ]]; then   ## no ip, so it's free
            echo "${iface}:$i"
            return 0    ## return directly, not use break
        fi
        
        (( i++ ))
    done
        
    return 1
}

## check if we have at least a sub interface, may used on lvs box
## return true / false
has_sub_iface()
{
    ## /sbin/ifconfig | grep -m1 -Eq '^eth[0-9]+:[0-9]+'
    /sbin/ifconfig | grep -m1 -Eq '^(eth[0-9]+|lo):[0-9]+'
}

has_localip()
{
    local ip=$1

    get_localip_all | xargs -n1 | grep -Eq "^$ip$"
}

has_wanip()
{
    local ip=$1

    get_wanip_all | xargs -n1 | grep -Eq "^$ip$"
}

has_ip()
{
    local ip=$1

    get_interface_by_ip "$ip" &> /dev/null
}

is_ip_on_iface()
{
    local iface=$1
    local ip=$2

    if [[ $( get_ip_for_interface "$iface" ) == $ip ]]; then
        return 0
    else
        return 1
    fi
}

## include sub-iface
is_ip_on_iface_all()
{
    local iface=$1
    local ip=$2

    local ip_
    for ip_ in $( get_all_ip_for_interface "$iface" ); do
        ## found
        if [[ $ip_ == $ip ]]; then
            return 0
        fi
    done

    return 1
}

## call this fun two times, the increment is the flux
## argv: $interface
get_current_transmit_flux_for()
{
    local dev=$1
    local NETDEV="/proc/net/dev"

    grep -w "$dev" "$NETDEV" | awk -F: '{ print $2; }' | awk '{ print $9; }'

    return ${PIPESTATUS[0]}
}

## Average:        IFACE   rxpck/s   txpck/s   rxbyt/s   txbyt/s   rxcmp/s   txcmp/s  rxmcst/s
get_packet_in()
{
    local iface=$1
    local interval=$2
    local cnt=$3

    [[ -z $interval ]] && interval=4
    [[ -z $cnt      ]] && cnt=1

    sar -n DEV "$interval" "$cnt" | grep -E "^Average:[[:blank:]]+$iface[[:blank:]]+" |
      awk '{ print $3 }'
    
}

get_packet_out()
{
    local iface=$1
    local interval=$2
    local cnt=$3

    [[ -z $interval ]] && interval=4
    [[ -z $cnt      ]] && cnt=1

    sar -n DEV "$interval" "$cnt" | grep -E "^Average:[[:blank:]]+$iface[[:blank:]]+" |
      awk '{ print $4 }'
    
}

get_flux_in()
{
    local iface=$1
    local interval=$2
    local cnt=$3

    [[ -z $interval ]] && interval=4
    [[ -z $cnt      ]] && cnt=1

    sar -n DEV "$interval" "$cnt" | grep -E "^Average:[[:blank:]]+$iface[[:blank:]]+" |
      awk '{ print $5 }'
    
}


get_flux_out()
{
    local iface=$1
    local interval=$2
    local cnt=$3

    [[ -z $interval ]] && interval=4
    [[ -z $cnt      ]] && cnt=1

    sar -n DEV "$interval" "$cnt" | grep -E "^Average:[[:blank:]]+$iface[[:blank:]]+" |
      awk '{ print $6 }'
    
}

## try to find default gw, return the most used ip if default gw not found
## this func check gw ip loosely, check following code
get_gateway_ip()
{
    /bin/netstat -nr | perl -lnwe '
        next unless /eth\d+/;

        ( $dest, $gw ) = (split)[0,1];
        if ( $dest eq "0.0.0.0" ) {
            $default_gw = $gw;
        }
        else {  
            $rec{ $gw }++; 
        }

        END {
        if ( defined $default_gw ) {
            print $default_gw;
            exit 0;
        }
    
        $max = 0;
        for $g ( keys %rec ) {
            if ( $rec{ $g } > $max ) {
                $max = $rec{ $g };
                $default_gw = $g;
            }
        }
        print "$default_gw";
    }'
}

## this func check DEFAULT gw ip, may return more than one ip !
get_default_gateway_ip_on_interface()
{
    local iface=$1

    /bin/netstat -nr |
    awk -vifc="$iface" '{ if ($1 == "0.0.0.0" && $NF == ifc) { print $2 } }'  
}

## may return more than 1 ip, check it by yourself !
## this func check gwip loosely, check following code
get_gateway_ip_on_interface()
{   
    local ifc=$1

    if [[ -z $ifc ]]; then
        return 1
    fi

    netstat -nr | perl -lne '
        BEGIN{ $ifc = pop @ARGV; }

        next unless /^\d/;

        if (/^0\.0\.0\.0\s+(\d+\.\d+\.\d+\.\d+).*$ifc\s*$/) {
            $found=1;
            print $1;
            exit 0;
        }
        elsif (/^\d+\.\d+\.\d+\.\d+\s+(\d+\.\d+\.\d+\.\d+).*$ifc\s*$/) {
            next if $1 eq "0.0.0.0";
            $gw{$1}++;

            ## print "found [$_]"
        }

        END {
            unless ( $found ) {
                for ( sort keys %gw ) {
                    ## print "$_\t$gw{$_}";
                    print $_;
                }
            }
        }

    ' "$ifc"
}

## check if a host online
## return true / false
is_host_online()
{
    local host=$1
    local try=$2

    [[ -n $try ]] || try=2

    [[ -n $host ]] || return 1

    ## some old versions of nmap seems more slowly when dest unreachable
    while (( try >= 0 )); do
        if ping -c2 -w2 "$host" 2>/dev/null | grep -q ' [12] received'; then
            return 0
        fi

        (( try-- ))
    done

    return 1
}

## return true / false
is_a_valid_port()
{
    local port=$1
    local p=$( echo $port | tr -d '0-9' )

    ## having non-digit character
    if [[ -n "$p" ]]; then
        return 1
    fi
    
    if (( port >= 1 )) && (( port <= 65535 )); then
        return 0
    else
        return 1
    fi
}

## return true / false
is_an_valid_ip()
{
    local ip=$1

    ## simple checking
    if [[ "$ip" == "0.0.0.0" ]] || [[ "$ip" == "255.255.255.255" ]]; then
        return 1
    fi

    ## not perfect checking ...
    echo "$ip" | grep -qE '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'
}


## return 0:  down ok
## return 1:  down notok
## return 2:  ip not found

## down a specific interface which has the vip
ifdown_an_ip()
{
    local ip=$1
    local iface=$2
    
    [[ -n $ip ]] || return 1

    for ip_ in $( get_all_ip_for_interface "$iface" ); do
        if [[ $ip == $ip_ ]]; then
            iface_=$( get_interface_by_ip "$ip" "$iface" )
            ifdown_an_iface "$iface_" && return 0 || return 1
        fi
    done

    return 2
}

## dangerous to down a phycal interface, use "force" as argv[2] if you know what you are doing
ifdown_an_iface()
{
    local iface=$1
    local downall=$2

    local ip_cnt

    [[ -n $iface ]] || return 1

    case $iface in
    *:[0-9]*)   ## sub interface, just clear the ip configured
        /sbin/ifconfig "$iface" 0 &> /dev/null || :
        ;;
    *)  ## physical interface, if there is only one ip, down the nic
        ## else just clear the ip configured
        ip_cnt=$( get_all_ip_for_interface "$iface" | xargs -n1 | wc -l )
        if (( ip_cnt > 1 )); then
            if [[ $downall == "force" ]]; then
                /sbin/ifconfig "$iface" 0 down &> /dev/null || :
            else
                /sbin/ifconfig "$iface" 0      &> /dev/null || :
            fi
        ## no mare than 1 ip on it, safe
        else
            /sbin/ifconfig "$iface" 0 down     &> /dev/null || :
        fi
        ;;
    esac

    if [[ -z $( get_ip_for_interface "$iface" ) ]]; then
        return 0
    else
        return 1
    fi
}

use_ip_2ping()
{
    local src_ip=$1
    local dest_ip=$2

    local cnt=5

    while (( cnt >= 0 )); do
        #ping -c2 -w2 -I "$src_ip" "$dest_ip" 2>/dev/null | 
        # grep -q '[[:blank:]]0% packet loss'

        if ping -c3 -w3 -I "$src_ip" "$dest_ip" 2>/dev/null | grep -q ' [123] received'; then
            return 0
        fi

        (( cnt-- ))
    done

    return 1
}


get_irqnum_for()
{
    local dev=$1
    local irqn

    [[ $dev ]] || return 1

    irqn=$( 
        awk -vd=$dev ' $NF == d { 
          d_ = $1; 
          gsub( ":", "", d_ ); 
          print d_;
         }' /proc/interrupts 
    )

    if [[ $irqn ]]; then
        echo $irqn
        return 0
    else
        return 1
    fi
}

set_affinity_for()
{
    local irqn=$1
    local mask=$2

    local affinity_file="/proc/irq/$irqn/smp_affinity"

    [[ -f $affinity_file ]] || return 1
    [[ -w $affinity_file ]] || return 1

    echo "$mask" > "$affinity_file"
}


get_iface_cnt()
{
    grep -cP '\s*eth' /proc/net/dev 
}

get_nic_speed()
{
    local nic=$1

    ethtool "$nic" 2>/dev/null | awk '/Speed:/ { print $2 }' 
}

is_ip_private()
{
    local ip=$1

    is_an_valid_ip "$ip" || return 2
    
    case "$ip" in
    192.*|172.*|10.*)
        return 0 ;;
    esac

    return 1
}
## ---------------------------------------------------------





## ------------------- file / dir /path / --------------------------

## get the working dir name, may return the dirname of the script we are running
## actually, we may have to find the workdir first to source this file -_-!
## anyway, var LLLOG needs this
get_workdir()
{
    local d

    ## may be I should check $0 ~ *.sh simplly
    case $- in
        *i*)    ## sourced in an interactive-bash ?
            d=$( pwd )
            ;;
        *)
            d=$( cd `dirname -- "$0"` && pwd )
            ;;
    esac

    echo "$d"
}

## rename a file or dir to make sure the filename or dirname would be OK to reuse
## if "abc" exits, it will be renamed as "abc.old"
## argv: $pathname
## example: remove_old "/usr/local/apache" && ./configure --prefix=/usr/local/apache
remove_old()
{
    local name="$1"
    local oldname="${name}.old"

    ## trim ending "/"
    echo "$name" | perl -pe 's#/$##'

    if ! [[ -e "$name" || -L "$name" ]]; then
        return
    fi
    
    ## never rename '/', $1 must be an error argv
    [[ "$name" == "/" ]] && die "you really rename / ?"

    [[ -e "$oldname"  ]] && rm -rf "$oldname"
    [[ -L "$oldname"  ]] && rm -rf "$oldname"

    /bin/mv "$name" "$oldname"
}

## a simple mktemp. some old os have no /bin/mktemp, to create uniq temp file/dir
## the command on slk and suse behaves differently, so re-write it
## argv1: -d / -f
## argv2: $path
## example: mktemp -f /tmp/
mktemp()
{
    local opt=$1        ## file or dir
    local dir=$2        ## base path
    local tmp

    ## make sure we find a uniq file / dir name
    while :; do
        if [[ -n "$dir" ]]; then
            tmp="$dir/$( date +%s ).$$.$RANDOM"
        elif [[ -n "$WORKDIR" ]]; then
            tmp="$WORKDIR/$( date +%s ).$$.$RANDOM"
        else
            tmp="./$$.$RANDOM.$( date +%s )"
        fi

        [[ -e $tmp ]] || break
    done

    if [[ $opt == "-d" ]]; then
        mkdir -p "$tmp" || return 1
    else
        mkdir -p "$( dirname $tmp )" || return 1
        touch "$tmp"    || return 1
    fi

    echo $tmp
}

## essential files/dirs must be there
## argv: $pathname
## example: must_exist "$WORKDIR/mysql.tar.bz"
must_exist()
{
    local t
    local flag=0

    for t; do
        if [[ -e "$t" ]]; then
            logmsg "[$t] FOUND, OK"
        else
            flag=1
            warn "[$t] NOT FOUND, NOTOK"
        fi
    done

    (( flag != 0 )) && die "FILES NOT FOUND, ABORTING ..."
}

## try to find the mountpoint for a pathname
get_mountpoint_for_pathname()
{
    local path=$1
    
    [[ -n $path ]] || return 1
    [[ -e $path ]] || return 1

    df "$path" 2>/dev/null | awk 'NR == 2 { print $NF }'
}
    
    ## try to find the mountpoint for a pathname
    get_devname_for_mountpoint()
    {
        local path=$1
    
        [[ -n $path ]] || return 1
        [[ -d $path ]] || return 1
    
        df "$path" 2>/dev/null | awk 'NR == 2 { print $1 }'
    }
    
    ## get the file's owner
    get_file_owner()
    {
        local f=$1
    
        \ls -ld "$f" 2>/dev/null |
            awk '{ print $3 }'
    }
    
    ## get the file's group
    get_file_group()
    {
        local f=$1
    
        \ls -ld "$f" 2>/dev/null |
            awk '{ print $4 }'
    }
    
    ## get the file's permission
    get_file_permission()
    {
        local f=$1
    
        [[ -e  $f ]]             || return 1
        [[ -r $( dirname $f ) ]] || return 1
    
        perl -we '
            $a = (stat $ARGV[0])[2];
            printf "%04o\n", $a & 07777;
         ' "$f"
    }
    
    ## ---------------------------------------------------------
    
    
    
    
    
    
    ## --------------------- OS / HW info ----------------------
    
    ## check if running on SUSE OS
    ## return true / false
    check_suseos()
    {
        if [[ -f "/etc/SuSE-release" ]]; then
            grep -wqF 'SUSE' /etc/SuSE-release && return 0
        fi
    
        [[ -x /sbin/yast2 ]]  && return 0 || :
        
        return 1
    }
    
    ## check if running on Slackware OS
    ## return true / false
    check_slkos()
    {
        if [[ -f "/etc/slackware-version" ]]; then
            grep -wqF 'Slackware' /etc/slackware-version &>/dev/null && return 0
        fi
    
        [[ -x /sbin/installpkg ]]  && return 0 || :
    
        return 1
    }
    
    ## check if running on RedHat OS
    ## return true / false
    check_rhos()
    {
        if [[ -f /etc/redhat-release ]]; then
            grep -wqi red /etc/redhat-release &>/dev/null && return 0
        fi
    
        return 1
    }
    
    ## print OS info, now just os version 
    get_osinfo()
    {
        ## use xargs to delete '\n', I love xargs!
        if check_suseos; then
            xargs < /etc/SuSE-release
        elif check_slkos; then
            xargs < /etc/slackware-version
        elif check_rhos; then
            xargs < /etc/redhat-release
        else
            ## lsb_release may be found on ubuntu, debian, etc.
            lsb_release -d 2>/dev/null || echo 'UNKNOWD OS'
        fi
    }
    
    ## print OS name
    get_osname()
    {
        if check_suseos; then
            echo SUSE
        elif check_slkos; then
            echo SLK
        elif check_rhos; then
            echo RH
        else
            echo UNKNOWN
            return 1
        fi
    }
    
    ## with bit flag
    get_osname2()
    {
        echo $( get_osver )_$( get_cputype )
    }
    
    ## return 32/64, based on OS but not hardware
    get_cputype()
    {
        if uname -a | grep -Fq 'x86_64'; then
            echo 64
        else
            echo 32
        fi
    }
    
    get_osver()
    {
        if grep -Eq 'Slackware[[:blank:]]+8\.[0-9]'  /etc/slackware-version; then
            echo slk8
        elif grep -Eq 'Slackware[[:blank:]]+10\.[0-9]'  /etc/slackware-version; then
            echo slk10
        elif check_suseos; then
            echo "suse$( get_cputype )"
        elif check_rhos; then
            echo "rh$( get_cputype   )"
        else
            echo "UNKNOWN"
        fi 2>/dev/null
    }
    
    ## return kernel version: 2.4 / 2.6
    get_kernver()
    {
        /sbin/kernelversion 2>/dev/null ||
            uname -r | grep -o '^2\..'
    }
    
    ## get free capacity of a partition by a filename/pathname
    get_free_cap()
    {
        local path=$1
    
        if [[ ! -e "$path" ]]; then
            echo 0B
            return
        fi
    
        ## df so cool!
        df -h "$path" | awk 'NR==2 { print $4 }'
    }
    
    
    ## get the size of files by du
    ## example: get_file_size "/var/log"
    get_file_size()
    {
        ## do not quote [$file], may contain more than one filename
        local file=$1
        local size=$( du -sh $file 2>/dev/null | awk '{ print $1; exit }' || echo 0B )
    
        echo ${size: -1} | grep -q '^[0-9]$' && size=${size}B
        echo ${size:-0B}
    }
    
    ## get the size of physical mem
    get_mem_size()
    {
        local unit=$1
        local resut dividend
    
        case $unit in 
        k|K)
            dividend=1
            ;;
        m|M)
            dividend=1000
            ;;
        g|G)
            dividend=1000000
            ;;
        t|T)
            dividend=1000000000
            ;;
        *)
            dividend=1  ## default, K
            ;;
        esac
    
        resut=$( awk '/^MemTotal/ { print $2 }' /proc/meminfo )
        calculate2 "$resut / $dividend"
    }
    
    ## get the size of all hard disks
    get_hdd_size()
    {
        local unit=$1
        local resut dividend
    
        case $unit in 
        k|K)
            dividend=1
            ;;
        m|M)
            dividend=1000
            ;;
        g|G)
            dividend=1000000
            ;;
        t|T)
            dividend=1000000000
            ;;
        *)
            dividend=1  ## default, K
            ;;
        esac
    
        ## check /proc/partitions, fdisk -l not reliable
        resut=$( 
            awk 'BEGIN{ total = 0 }
            {
                if ( $1 !~ /^[[:space:]]*[0-9]+/ ) {
                    next
                }
            
                if ( $NF ~ /cciss\/c[0-9]d[0-9][[:space:]]*$/ || $NF ~ /[sh]d[a-z][[:space:]]*$/ ) {
                    total += $3
                }
            }
            END { printf("%d", total) }' /proc/partitions
        )
    
        calculate2 "$resut / $dividend"
    }
    
    ## get cpu name: intel/amd x $core_num
    get_cpu_name()
    {
        awk 'BEGIN{ num = 0; name = "unknow"; FS = ":" }
        {
            if ( $1 !~ /^model name/ ) {
                next
            }
            if ( $0 ~ /[Ii]ntel/ ) {
                name = "Intel"
            }
            else if ( $0 ~ /AMD/ ) {
                name = "Amd"
            }
            else {
                name = 'unknow'
            }
            num++
        }
        END { print name"x"num }' /proc/cpuinfo
    }
    
    ## get cpu cache sizes
    get_cpu_cachesize()
    {
        awk 'BEGIN{ num = 0; size = 0; FS = ":"; }
        {
            if ( $1 ~ /^cache size/ ) {
                num++
                size = $2 + 0
            }
        }
        END { print size"Kx"num }' /proc/cpuinfo
    }
    
    ## cnt of cpu core
    get_cpu_core_cnt()
    {
        grep -c cores /proc/cpuinfo
    }
    
    get_cpu_modename()
    {
        awk -F: '/^model name/ { print $2 }' /proc/cpuinfo | sed 1q | trim
    }
    
    
    ## 2009-01-14 samli, check if a partition readonly
    ## argv: $mountpoint / $pathname
    ## return true / false
    is_partition_readonly()
    {
        local p=$1
        local mountpoint
        local rw_flag
        
        mountpoint=$( get_mountpoint_for_pathname "$p" )
    
        ## rw_flag: ro / rw
        rw_flag=$(
          awk -vp=$mountpoint '
          {
              if ( $1 != "/dev/root" && $2 == p ) {
                  str=$4
                  gsub(",.*", "", str)
                  print str
                  exit
              }
          }' /proc/mounts )
          
          if [[ $rw_flag == "ro" ]]; then
              return 0
          else
              return 1
          fi
    }
    
    ## 2009-01-14 samli, check if a partition no space left
    ## argv: $mountpoint / $pathname
    ## return true / false
    is_partition_full()
    {
        local p=$1
        local full_flag
    
        case $p in
        /*)
            ;;
        *)
            return 1
            ;;
        esac
        
        ## check inode and data area
        full_flag=$( 
          { df -Pi "$p"; df -Pk "$p"; } |
           awk '! /^Filesystem/ {
             usage = $(NF-1) + 0
             if ( usage == 100 ) {
               print "Y"
               exit
             }
           }'
         )
    
        if [[ $full_flag == "Y" ]]; then
            return 0
        else
            return 1
        fi
    }  
    
    ## find the username we added manually
    ## see man shadow to find the detail of the policy
    find_non_sys_user()
    {
    
        # need root privilege to access '/etc/shadow'
        (( UID == 0 )) || return 1
    
        perl -we '
        use strict;
        my @users;
        my $fd;
        my ( $user, $pass, $uid );
        
        ## find the username having password
        open ($fd, "<", "/etc/shadow") or die "Can not open /etc/shadow\n";
        while (<$fd>) {
            ($user, $pass ) = (split ":")[0,1];
            next if $user eq "root";
        
            if ( $pass =~ m{ [a-zA-Z0-9/\$] }x ) {
                push @users, $user;
            }            
            elsif ( $pass eq "" ) {
                push @users, $user;
            }
        }
        close $fd or die "Can not close $fd\n";
    
        ## find the username having uid >= normal uid
        open ($fd, "<", "/etc/passwd") or die "Can not open /etc/passwd\n";
        while (<$fd>) {
            ($user, $uid ) = (split ":")[0,2];
            next if $user eq "root";
            next if $user eq "nobody";
        
            if ( $uid >= 1000 ) { ## should  read this val from /etc/login.defs
                push @users, $user unless grep { /\b$user\b/ }  @users;
            }
            elsif ( $uid == 0 ) { ## make sure dangerous user with uid = 0
                push @users, $user unless grep { /\b$user\b/ }  @users;
            }
        }
        close $fd or die "Can not close $fd\n";
    
        for my $u (sort @users) {
            print "$u", " ";
        }
        '
    }
    
    ## ---------------------------------------------------------
    
    
    
    
    
    
    ## ------------------------ KERNELL ------------------------
    ## check if kernel supports iptables
    ## return true / false
    kernel_support_iptables()
    {
        iptables -L -n &> /dev/null
    }
    
    ## check if kernel supports ip conntrack
    ## return true / false
    kernel_support_state()
    {
        ## [[ -f /proc/sys/net/ipv4/ip_conntrack_max ]]
        [[ -f /proc/net/ip_conntrack ]]
    }
    
    ## check if kernel supports lvs-rs by checking tunl interface 
    ## return true / false
    kernel_support_rs()
    {
        /sbin/ifconfig tunl0 &> /dev/null
    }
    
    ## check if kernel supports lvs-ld
    ## return true / false
    kernel_support_ld()
    {
        kernel_support_rs        || return 1
        [[ -f /proc/net/ip_vs ]] || return 1
    
        return 0
    }
    
    ## 2009-03-25, get the label name of stateful kernel from lilo.conf
    #+ but do not change 2.4->2.6 or 2.6->2.4 unthinkingly, nic name may change after reboot
    ## argv: 2.4 / 2.6
    get_state_label_for_slk()
    {
        ver=$1
    
        case $ver in
            2.4)    ##
                grep -m1 -E 'vmlinuz-2\.4.*STATE' /etc/lilo.conf -A4 |
                  awk -F= '/label/{ print $2 }'                      |
                  trim
                ;;
            2.6)
                grep -m1 -E 'vmlinuz-2\.6.*STATE' /etc/lilo.conf -A4 |
                  awk -F= '/label/{ print $2 }'                      |
                  trim
                ;;
            *)
                return 1
                ;;
        esac
    }
    
    ## ---------------------------------------------------------
    
    
    
    
    
    
    ## ------------------------ tarball ------------------------
    
    ## get tarball dirname,  /1/2/3/abc.tar.bz -> abc
    ## argv: $path_to_tarballname
    ## return dirname
    get_tarball_dirname()
    {
        local tb="$1"
        case $tb in
            *.tar.bz2|*.tar.gz)
                echo $tb | sed -e 's@.*/@@g' -e 's@\.tar\.\(bz2\|gz\)$@@'
                ;;
            *.tgz|*.tbz)
                echo $tb | sed -e 's@.*/@@g' -e 's@\.\(tbz\|tgz\)$@@'
                ;;
            *.tar)
                echo $tb | sed -e 's@.*/@@g' -e 's@\.tar$@@'
                ;;
            *)
                echo $tb
                return 1
                ;;
        esac
    }
    
    ## argv: $path_to_tarballname
    ## return bzip2 / gzip / tar
    get_tarball_type()
    {
        if file   "$1" | grep -Fq 'bzip2 compressed data'; then
            echo bzip2 
        elif file "$1" | grep -Fq 'gzip compressed data'; then
            echo gzip
        elif file "$1" | grep -Fq "POSIX tar archive"; then
            echo tar
        else
            return 1
        fi
    }
    
    untar()
    {
        local tarball=$1
        local tmpf=/tmp/.tmp_untar.aa
        local tardir
    
        [[ -f $tarball ]] || return 1
        touch "$tmpf"     || return 1
    
        if   tar tf "$tarball"  > "$tmpf" 2>/dev/null; then
             tar xf "$tarball"
        elif tar tzf "$tarball" > "$tmpf" 2>/dev/null; then
             tar xzf "$tarball"
        elif tjf "$tarball"     > "$tmpf" 2>/dev/null; then
             tar xjf "$tarball"
        fi
    
        if [[ -s $tmpf ]]; then
            tardir=$( head -n1 "$tmpf" )
    
            case "$tardir" in
            /)
                echo "$tardir"
                ;;
            *)
                echo "$( pwd )/$tardir"
                ;;
            esac
            
            return 0
        fi
    
        return 1
    }
    
    ## ---------------------------------------------------------
    
    
    
    
    
    
    ## ----------------------- TNM Agent ------------------------
    
    ## report data to nm using agentRepNum
    ## argv1: $ID  from tnm
    ## argv2: $num to report
    ## argv3: $ip  for who to report, optional
    ## example: send_report_data "10000" "123456" "1.1.1.1"
    send_report_data()
    {
        local id=$1
        local num=$2
        local ip=$3     ## optional
    
        ## old version not support "ip"
        if [[ -n "$ip" ]]; then
            /usr/local/agenttools/agent/agentRepNum "$ip" "$id" "$num"  &> /dev/null ||
            /usr/local/agenttools/agent/agentRepNum "$id" "$num"        &> /dev/null 
        else
            /usr/local/agenttools/agent/agentRepNum "$id" "$num"        &> /dev/null
        fi
    }
    
    ## send alert msg using agentRepStr
    ## argv1: $ID  from nm
    ## argv2: $str to send out
    ## argv3: $ip  for who to report, optional
    ## example: send_alert_msg "10000" "port 3306 not found, check ASAP" "$ip"
    send_alert_msg()
    {
        local id=$1
        local str=$2
        local ip=$3     ## optional
    
        ## old version not support "ip"
        if [[ -n "$ip" ]]; then
            /usr/local/agenttools/agent/agentRepStr "$ip" "$id" "$str" &> /dev/null ||
            /usr/local/agenttools/agent/agentRepStr "$id" "$str"       &> /dev/null 
        else
            /usr/local/agenttools/agent/agentRepStr "$id" "$str"       &> /dev/null
        fi
    }
    
    ## ---------------------------------------------------------
    
    
    
    
    
    
    ## --------------------------- NUM -------------------------
    
    ## a simple int calculater
    ## argv: "$math_expression"
    ## example: calculate "10 / 2"
    calculate()
    {
        local expr=$@
    
        if which bc &>/dev/null; then
            echo "scale = 0; $expr" | bc
        elif which perl &>/dev/null; then
            echo "$expr" | perl -lne ' print int (eval) '
        else
            echo $(( $expr ))
        fi
    }
    
    ## support float
    calculate2()
    {
        local expr=$@
    
        if which bc &>/dev/null; then
            echo "scale = 2; $expr" | bc
        elif which perl &>/dev/null; then
            echo "$expr" | perl -lne ' printf ("%0.2f",  (eval) ) '
        else    ## may try awk here
            return 1
        fi
    }
    ## check if argv1 >= argv2
    ## argv1: $num_1
    ## argv2: $num_2
    compare_two_num()
    {
        if (( $# != 2 )); then
            return 1
        fi
    
        ## hope perl is install in every OS ...
        perl -we ' my ($v1, $v2) = @ARGV; exit ( $v1 >= $v2 ? 0 : 1 ) ' $1 $2
    }
    
    ## get a random num
    ## argv: $max, optionall
    get_a_random_num()
    {
        local max=$1
        local rand=0
    
        if [[ -z $max ]]; then
            echo $(( RANDOM + 1 ))   ## 1 ~ 32768, see man bash
        else
            # echo $RANDOM$RANDOM % $1 | perl -lne ' print eval '
            while (( rand == 0 )); do
                ## 3276732767 < ( 2^32 = 4294967296 )
                rand=$( calculate "( $RANDOM$RANDOM + $RANDOM + $RANDOM ) % $max" )
            done
            echo $rand
        fi
    }
    
    ## get ntp time offset
    ## sorry to hear that ntpdate is deprecated in opensuse 11.1
    get_ntp_offset()
    {
        ## local NTP_SERVER="172.23.32.142 172.24.18.141 172.24.147.11 172.16.58.40 172.16.58.14"
        local NTP_SERVER_="172.23.32.142 172.24.18.141 172.24.147.11"
        local offset
    
        [[ -n $NTP_SERVER ]] && NTP_SERVER_="$NTP_SERVER"
    
        if [[ -n $1 ]]; then
            NTP_SERVER="$@"
        fi
    
        ## to speed up, just query one server every time
        ## so , the ntp server must be reliable
        for srv in $NTP_SERVER_; do
            offset=$( 
                /usr/sbin/ntpdate -q $srv 2> /dev/null  |
                awk '/time server.*sec$/ { print $( NF -1 ) }' |
                sed 's/-//' ## get abs val
            )
    
            if [[ -n $offset ]]; then
                echo $offset
                return 0
            fi
        done
    
        return 1
    }
    
    ## ---------------------------------------------------------
    
    
    
    
    
    
    ## ------------------------- MISC --------------------------
    
    dump_cron()
    {
        local user=$1
    
        local user_flag
    
        if [[ -n $user ]]; then
            if (( UID != 0 )); then
                return 1
            fi
    
            user_flag="-u $user"
        fi
    
        crontab $user_flag -l | 
         perl -lne ' print if ( ( $. > 3 ) || ( $. <= 3 && /^[^#] /) ) ' 
    }
    
    ## add a cron jobs line to crontab, with 'force' arg to add a comment line
    ## example: add_cron "### sync clock every hour" "force"
    ## example: add_cron "30 * * * * /usr/sbin/ntpdate 172.23.32.142 &> /dev/null"
    ## example: add_cron "30 * * * * /usr/sbin/ntpdate 172.23.32.142 &> /dev/null" "mqq"
    add_cron()
    {
        local cmd=$1
        local force=$2
        local user=$3
        local key
        local is_comment
    
        local user_flag
    
        if [[ -n $user ]]; then
            if (( UID != 0 )); then
                return 1
            fi
    
            user_flag="-u $user"
        fi
    
        # good to use absolute path in crontab
        local c
        for c in $cmd; do
            case $c in
                /*)
                    ## key=$( basename $c )
                    key=$c
                    break
                    ;;
            esac
        done
    
        if ! [[ $force == "force" || $force == "FORCE" ]]; then
            if [[ -z "$key" ]]; then
                warn "failed, [$cmd] not use abs_path to command"
                return 1
            fi
    
            if [[ ! -x "$c" ]]; then
                warn "failed, [$c] not executable"
                return 1
            fi
    
            if crontab $user_flag -l | grep -F -v '#' | grep -Fqw -- "$key"; then
                warn "failed, keyword [$key] found in crontab already"
                return 1
            fi
        fi
    
        if echo "$cmd" | grep -Eq '^[[:blank:]]+#'; then
            is_comment=yes
        fi
    
        # update crontab
        # crontab $user_flag -l | perl -lne ' print if ( ( $. > 3 ) || ( $. <= 3 && /^[^#] /) ) ' |
        dump_cron "$user" |
        {   
          cat 
          [[ $is_comment == "yes" ]] || echo "## [$( basename $key )], $(date '+%F %T')"
          echo  "$cmd"
        } | crontab - $user_flag
    }    
    
    comment_cron()
    {
        local key=$1
        local user=$2
    
        local user_flag
    
        [[ -n $key ]] || return 1
    
        if [[ -n $user ]]; then
            if (( UID != 0 )); then
                return 1
            fi
    
            user_flag="-u $user"
        fi
    
        # crontab $user_flag -l | perl -lne ' print if ( ( $. > 3 ) || ( $. <= 3 && /^[^#] /) ) ' |
        dump_cron "$user" |
         sed "/$key/ s/^/## /" | crontab - $user_flag
    }
    
    del_cron()
    {
        local key=$1
        local user=$2
    
        local user_flag
    
        [[ -n $key ]] || return 1
    
        if [[ -n $user ]]; then
            if (( UID != 0 )); then
                return 1
            fi
    
            user_flag="-u $user"
        fi
    
        ## nonsense 3 lines header
        # crontab $user_flag -l | perl -lne ' print if ( ( $. > 3 ) || ( $. <= 3 && /^[^#] /) ) ' |
        dump_cron "$user" |
         grep -v -- "$key" | crontab - $user_flag
    }
    
    ## trim leading space and tailing space
    ## example: iptables -nvL | trim
    ## example: trim < file
    trim()
    {
        sed -e 's/^[[:space:]]\+//' -e 's/[[:space:]]\+$//'
    }
    
    ## check if a string already in a file which is not commented
    ## argv1: $str
    ## argv2: $filename
    ## return true / false
    is_str_infile()
    {
        local str="$1"
        local file="$2"
    
        grep -Fv '#' "$file" | grep -Fwq -- "$str"
    }
    
    ## kill a process if it's running
    ## argv: $app_name
    try_kill_proc()
    {
        local proc="$1"
    
        if killall -0 "$proc" &>/dev/null; then
            if killall -9 "$proc"; then
                logmsg "found old "$proc" running, kill OK"
            else
                die "found old "$proc" running, kill FAILED"
            fi
        fi
    }
    
    ## to grep multipul times, supposed to be used after a pipe or with read redirection
    ## example: ps -ef | mgrep samli ssh
    mgrep()
    {
        local key="$1"
        local opt=
    
        if [[ -z "$key" ]]; then
            cat     
            return  
        fi
    
        while [[ ${key:0:1} == '-' ]]; do
            opt="$opt $key"
            shift
            key="$1"
        done
    
        shift   
        grep $opt $key | mgrep "$@"
    }
    
    
    ## thanks kangkang 
    dectobin()
    {
        local s=$1
        local n 
    
        while (( $s != 0 )); do
            n=$(( s % 2 ))$n
            s=$(( s / 2 ))
        done    
    
        echo $n 
    }
    
    ## thanks kangkang 
    cidr_mask()
    {
        
        local mask=$1
        local out i
    
        for i in $( echo $mask | tr '.' ' ' ); do
            out=$out$(dectobin $i)
        done
        
        out=$(echo $out | sed 's/0*$//g' )
    
        if echo $out | grep -q 0; then
            return 1
        fi
    
        echo -n $out | wc -c
    }
    
    
    
    ## a better cidr_mask func, from dearvoid@eden.com
    ## mask2bits()
    ## {
    ##     local aMask i nBits=0
    ##     
    ##     aMask=( ${1//./\ } )
    ##     for ((i = 0; i < 4; ++i)); do
    ##         while (( aMask[i] )); do
    ##             ((++nBits, aMask[i] *= 2, aMask[i] &= 255))
    ##         done
    ##     done
    ##     
    ##     echo $nBits
    ## }
    
    
    ## xor op, usring P$1" 
    ## argv[1]: key to xor with
    ## argv[2]: str to xor
    myxor()
    {
        local key=$1
        local str=$2
    
        perl -lwe ' 
            my $key = shift;
            $_ = shift;
            my @new;
            for my $s ( split( "" ) ) {
                push @new, chr( (ord $s) ^ $key );
            }
            print join "", @new;
        ' "$key" "$str"
    }
    
    ## get_name_of_pid()
    ## {
    ##     local pid=$1
    ## 
    ##     /bin/ls -l "/proc/$pid/exe" 2>/dev/null
    ## }
    
    is_dos_file()
    {
        local file=$1
    
        file "$file" | grep -q 'CRLF'
    }
    
    ## dos2unix is lost on some servers -_-!
    my_dos2unix()
    {
        local file=$1
    
        if which dos2unix ; then
            ## some strange dosunix will not work with abs-path
            (
                cd "$( dirname $file )"
                dos2unix "$file"
            )
        else
            perl -pi -e 's/\r$//' "$file"
        fi &> /dev/null
    }
    
    dos2unix_if_necessary()
    {
        local file=$1
    
        [[ -f $file ]] || return 1
    
        if is_dos_file "$file"; then
            my_dos2unix "$file"
        else
            return 0
        fi
    }
    
    ## find the java dirname without unpacking jdk*.bin
    ## we may return [jdk1.5.0_06] for [jdk-1_5_0_06-linux-i586.bin]
    get_javadir_from_javabin()
    {
        javabin=$1  ## such as [jdk-1_5_0_06-linux-i586.bin]
    
        if [[ -z $javabin ]] || [[ ! -f $javabin ]]; then
            return 1
        fi
    
        grep -m1 -a '^javahome=jdk.*' "$javabin" |
          awk -F= '{ print $2 }'
    }
    
    ## ---------------------------------------------------------
    
    
    
    
    ## ----------------------- PROCESS -------------------------
    
    ## check if a given pid/appname running
    ## argv: pid / appname
    is_app_running()
    {
        local $p=$1
        local RC
    
        [[ -n $p ]] || return 1
        
        ## pid
        if [[ -z $( echo $p | tr -d '[0-9]') ]]; then
            kill -0 "$p" &> /dev/null
            RC=$?
        ## app name
        else
            killall -0 "$p" &> /dev/null
            RC=$?
        fi
    
        return $RC
    }
    
    lock_on()
    {
        local f=$1
        local freefd=6  ## do not use fd 5
    
        ## make sure the file be there
        mkdir -p "$( dirname $f )"
        touch "$f"
    
        ## find a free fd
        while (( freefd <= 1024 )); do
            [[ -L /dev/fd/$freefd ]] || break
            (( freefd++ ))
        done
    
        ## (( freefd == 10 )) && return 1
    
        ## open the lock file, may fail, caller should chek $?
        eval "exec $freefd< \"$f\""
    }
    
    is_locked()
    {
        local f=$1
    
        fuser "$f" &> /dev/null
    }
    
    
    ## ------------------------ strings ------------------------
    upper()
    {
        local str
    
        if [[ -n "$@" ]]; then
            str="$@"
        ## read from pipe
        elif [[ -p /dev/fd/0 ]] || [[ $1 == "-" ]]; then
            str=$( cat - )
        
        ## readirected input
        elif [[ -f /dev/fd/0 ]]; then
            str=$( cat - )
        fi
    
        echo "$str" | tr 'a-z' 'A-Z'
    }
    
    lower()
    {
        local str
    
        if [[ -n "$@" ]]; then
            str="$@"
        ## read from pipe
        elif [[ -p /dev/fd/0 ]] || [[ $1 == "-" ]]; then
            str=$( cat - )
        
        ## readirected input
        elif [[ -f /dev/fd/0 ]]; then
            str=$( cat - )
        fi
    
        echo "$str" | tr 'A-Z' 'a-z'
    }
    
    ## -------------------- init global vars -------------------
    
    ## init LLLOCALIP, do not delete following line, logmsg/warn/die use this val
    LLLOCALIP=$( get_localip )
    
    ## init WORKDIR
    #[[ -n $WORKDIR ]]  || WORKDIR=$( get_workdir )
    WORKDIR=$( get_workdir )
    
    ## init LLLOG, LLLOGDIR 
    ## this val must be used after the logdir created in func logmsg/logmsg_/warn/die
    [[ -n $LLLOG    ]] || LLLOG="$WORKDIR/log.d/log.$LLLOCALIP"
    [[ -n $LLLOGDIR ]] || LLLOGDIR=${LLLOG%/*}
    
    ## ---------------------------------------------------------
