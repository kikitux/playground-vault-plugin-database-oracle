#!/usr/bin/env bash

export PKG_CONFIG_PATH=/vagrant/pkg

mkdir -p `go env GOPATH`
pushd `go env GOPATH`

mkdir -p src/github.com/hashicorp/

[ -d src/github.com/hashicorp/vault ] || git clone https://github.com/hashicorp/vault src/github.com/hashicorp/vault
[ -d src/github.com/hashicorp/vault-plugin-database-oracle ] || git clone https://github.com/hashicorp/vault-plugin-database-oracle src/github.com/hashicorp/vault-plugin-database-oracle
pushd src/github.com/hashicorp/vault-plugin-database-oracle
go build -o vault-plugin-database-oracle ./plugin

ls -alh vault-plugin-database-oracle
ldd vault-plugin-database-oracle

popd
popd
