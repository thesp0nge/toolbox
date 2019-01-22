#!/bin/bash
#
# A useless script to calculate the network address with the CIDR /xx notation
# in pure bash.
# 
# (c) 2019 - thesp0nge - paolo@armoredcode.com
# 
# I started from this gist I found on Github:
# https://gist.github.com/hmmbug/e386274e299ab4d00a9f. The hostname -i command
# doesn't work for a machine resolvng as localhost, i.e. a virtualbox machine. 
# We must consider also hosts with more than a network card... so the interface
# must be a variable parameter.
#
# Then I used this IPprefix_by_netmask implementation in bash I found on
# StackOverflow:
# https://stackoverflow.com/questions/50413579/bash-convert-netmask-in-cidr-notation

IPprefix_by_netmask () { 
   c=0 x=0$( printf '%o' ${1//./ } )
   while [ $x -gt 0 ]; do
       let c+=$((x%2)) 'x>>=1'
   done
   echo /$c ; }
IPconfig_to_netaddr () {
	line=`ifconfig -a $net_i | grep netmask | tr -s " "`
	ip=`echo $line | cut -f 2 -d " "`
	mask=`echo $line | cut -f 4 -d " "`

	IFS=. read -r io1 io2 io3 io4 <<< $ip
	IFS=. read -r mo1 mo2 mo3 mo4 <<< $mask
	NET_ADDR="$((io1 & mo1)).$(($io2 & mo2)).$((io3 & mo3)).$((io4 & mo4))"

	echo $NET_ADDR`IPprefix_by_netmask $mask` ; }

if [ "$#" -ne 1 ]; then
	echo "usage: $0 network interface"
	exit 2
fi
net_i=$1
found=`ifconfig -a $net_i 2> /dev/null`
if [ $? -eq 1 ]; then
	echo $0: $net_i interface not found
	exit 1
fi
IPconfig_to_netaddr $net_i


