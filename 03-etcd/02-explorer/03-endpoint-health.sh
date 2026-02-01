#!/usr/bin/env bash

source /root/etcdctl.env

etcdctl endpoint health --write-out=table
