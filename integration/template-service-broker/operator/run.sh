#!/bin/sh

NSS_WRAPPER_PASSWD=/operator/tmp/passwd
NSS_WRAPPER_GROUP=/operator/tmp/group

cp /etc/passwd $NSS_WRAPPER_PASSWD
cp /etc/group $NSS_WRAPPER_GROUP
echo operator:x:$(id -u):$(id -g):operator:/operator:/bin/sh >> $NSS_WRAPPER_PASSWD

export LD_PRELOAD=libnss_wrapper.so
export NSS_WRAPPER_PASSWD
export NSS_WRAPPER_GROUP

exec kopf run --standalone /operator/poolboy-tsb.py
