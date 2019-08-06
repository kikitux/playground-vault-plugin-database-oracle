#!/usr/bin/env bash

# pkg-config for instant client
export PKG_CONFIG_PATH=/vagrant/pkg

mkdir -p `go env GOPATH`
pushd `go env GOPATH`

mkdir -p src/github.com/hashicorp/

# download vault
[ -d src/github.com/hashicorp/vault ] || git clone https://github.com/hashicorp/vault src/github.com/hashicorp/vault

# download vault-plugin-database-oracle
[ -d src/github.com/hashicorp/vault-plugin-database-oracle ] || git clone https://github.com/hashicorp/vault-plugin-database-oracle src/github.com/hashicorp/vault-plugin-database-oracle

# build vault-plugin-database-oracle
pushd src/github.com/hashicorp/vault-plugin-database-oracle
go build -o vault-plugin-database-oracle ./plugin

# show size and dependencies
ls -alh vault-plugin-database-oracle
ldd vault-plugin-database-oracle

# copy plugin to vault plugin directory
mkdir -p /usr/local/vault/plugins
cp vault-plugin-database-oracle /usr/local/vault/plugins/

# grab sha256
sha256=($(sha256sum /usr/local/vault/plugins/vault-plugin-database-oracle))

export VAULT_ADDR=http://localhost:8200

# enable secrets database if not enabled
[[ "`/usr/local/bin/vault secrets list`" =~ "database/" ]] || {
  /usr/local/bin/vault secrets enable database
}

# register the plugin
/usr/local/bin/vault write sys/plugins/catalog/database/vault-plugin-database-oracle \
  sha_256=${sha256} \
  command="vault-plugin-database-oracle"

popd
popd
