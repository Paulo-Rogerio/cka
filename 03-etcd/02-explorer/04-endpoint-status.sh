#!/usr/bin/env bash

source /root/etcdctl.env

etcdctl endpoint status --write-out=table
