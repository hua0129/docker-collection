#!/bin/bash

this_dir=$(cd `dirname $0`; pwd)

base_dir=${this_dir/\/remote*/}

source setup.profile

#ansible_cdh=ansible_longdb_update
[ $MODE != passwd ] && ssh -i pem/ssh-key.pem $user@${IPS[0]} "mkdir -p /opt/$ansible_cdh"
[ $MODE == passwd ] && ssh $user@${IPS[0]} "mkdir -p /opt/$ansible_cdh"

[ $MODE != passwd ] && scp -i pem/ssh-key.pem -r $base_dir/* $user@${IPS[0]}:/opt/$ansible_cdh
[ $MODE == passwd ] && scp -r $base_dir/* $user@${IPS[0]}:/opt/$ansible_cdh

echo ====================================scp finished===========================================

