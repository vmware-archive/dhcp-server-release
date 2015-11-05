#!/bin/bash -e

JOB_NAME=dhcpd
BASE_DIR=/var/vcap
SYS_DIR=$BASE_DIR/sys
RUN_DIR=$SYS_DIR/run/$JOB_NAME
LOG_DIR=$SYS_DIR/log/$JOB_NAME
JOB_DIR=$BASE_DIR/jobs/$JOB_NAME
CONFIG_DIR=$JOB_DIR/etc
CONFIG_FILE=$CONFIG_DIR/dhcpd.conf
PERSISTENT=$BASE_DIR/store
LEASE_FILE=$PERSISTENT/dhcpd.leases
PIDFILE=$RUN_DIR/$JOB_NAME.pid

mkdir -p $RUN_DIR $LOG_DIR $CONFIG_DIR
touch $LEASE_FILE

case $1 in

  start)
    $BASE_DIR/packages/dhcp-4.3.3/sbin/$JOB_NAME -pf $PIDFILE -cf $CONFIG_FILE -lf $LEASE_FILE
    ;;
  stop)
    kill $(cat $PIDFILE)
    ;;
  *)
    echo "Usage: ctl {start|stop}"
    ;;
esac
