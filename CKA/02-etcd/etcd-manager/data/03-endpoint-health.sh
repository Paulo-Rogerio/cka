#!/usr/bin/env bash

source ./01-env.sh

etcdctl endpoint health --write-out=table
