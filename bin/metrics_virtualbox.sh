#!/bin/sh
# basic setup
DIR=`pwd`
BIN_DIR=`dirname $0`
. $BIN_DIR/setup.sh
# vagrant up machines
vagrant up --provision
