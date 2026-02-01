#!/usr/bin/env bash

source /root/etcdctl.env

etcdctl member list --write-out=table
