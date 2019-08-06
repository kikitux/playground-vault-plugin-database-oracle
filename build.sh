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

mkdir -p /usr/local/vault/plugins
cp vault-plugin-database-oracle /usr/local/vault/plugins/

sha256=($(sha256sum /usr/local/vault/plugins/vault-plugin-database-oracle))

export VAULT_ADDR=http://localhost:8200

/usr/local/bin/vault write sys/plugins/catalog/database/vault-plugin-database-oracle \
	    sha_256=${sha256} \
	        command="vault-plugin-database-oracle"

popd
popd
