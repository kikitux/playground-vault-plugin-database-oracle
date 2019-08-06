#!/usr/bin/env bash

# lets use last golang
yum install -y oracle-golang-release-el7
yum install -y golang

# install other dev tools
yum group install -y 'Development Tools'
yum install -y git libnsl libaio curl wget jq
