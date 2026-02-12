#!/usr/bin/env bash

source ./01-env.sh

etcdctl endpoint status --write-out=table
