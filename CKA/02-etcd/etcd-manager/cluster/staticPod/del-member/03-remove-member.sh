#!/usr/bin/env bash

source ./01-env.sh

[[ -z $1 ]] && echo "Deve-se informar o Id do membro. Ex: ( 8211f1d0f64f3269 )" && exit 1;

etcdctl member remove $1
