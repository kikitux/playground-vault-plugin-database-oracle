#!/usr/bin/env bash

yum install -y oracle-golang-release-el7
yum install -y golang

yum group install -y 'Development Tools'
yum install -y git libnsl libaio
