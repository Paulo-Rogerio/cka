#!/usr/bin/env bash

source /root/etcdctl.env

etcdctl --endpoints=https://localhost:2379 del chave3
