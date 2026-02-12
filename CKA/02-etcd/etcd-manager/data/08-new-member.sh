#!/usr/bin/env bash

source ./01-env.sh

etcdctl member add master03 --peer-urls=https://10.100.100.13:2380
