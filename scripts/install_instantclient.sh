#!/usr/bin/env bash

# update yum repo
yum install -y oracle-release-el7

# install instantclient19.3
yum install -y oracle-instantclient19.3-basic
yum install -y oracle-instantclient19.3-devel
