
#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive
export PATH="/opt/puppetlabs/bin:$PATH"

PUPPET_SERVER_NAME="utn-devops.localhost"
MANIFEST_SOURCE="/vagrant/puppet/manifests/site.pp"
MANIFEST_DEST="/etc/puppetlabs/code/environments/production/manifests/site.pp"

echo "=== Actualizando paquetes ==="
apt-get update
apt-get install -y ca-certificates curl wget

echo "=== Configurando repositorio de Puppet 7 ==="
wget -q https://apt.puppet.com/puppet7-release-jammy.deb \
  -O /tmp/puppet7-release-jammy.deb
dpkg -i /tmp/puppet7-release-jammy.deb
apt-get update

echo "=== Instalando Puppet Server ==="
apt-get install -y puppetserver

echo "=== Verificando usuario y grupo de Puppet ==="
getent group puppet >/dev/null || groupadd --system puppet

if ! id puppet >/dev/null 2>&1; then
  useradd --system --gid puppet --home-dir /var/lib/puppet \
    --create-home --shell /usr/sbin/nologin puppet
fi

echo "=== Ajustando memoria de Puppet Server ==="
sed -i 's/^JAVA_ARGS=.*/JAVA_ARGS="-Xms512m -Xmx512m"/' \
  /etc/default/puppetserver

echo "=== Configurando servidor y agente ==="
install -d -m 0755 /etc/puppetlabs/puppet

cat > /etc/puppetlabs/puppet/puppet.conf <<EOF
[main]
certname = ${PUPPET_SERVER_NAME}
server = localhost
environment = production
runinterval = 30m

[server]
dns_alt_names = localhost,${PUPPET_SERVER_NAME}
EOF

echo "=== Copiando manifiesto de Puppet ==="
test -f "$MANIFEST_SOURCE"
install -d -m 0755 "$(dirname "$MANIFEST_DEST")"
install -m 0644 "$MANIFEST_SOURCE" "$MANIFEST_DEST"

echo "=== Habilitando Puppet Server ==="
systemctl enable --now puppetserver

echo "=== Esperando a Puppet Server ==="
for i in $(seq 1 60); do
  if curl -ks https://localhost:8140/ >/dev/null; then
    break
  fi
  sleep 2
done

if ! curl -ks https://localhost:8140/ >/dev/null; then
  echo "ERROR: Puppet Server no respondió en el puerto 8140"
  systemctl status puppetserver --no-pager || true
  exit 1
fi

echo "=== Ejecutando el agente de Puppet ==="
puppet agent --test --server localhost

echo "=== Habilitando el agente de Puppet ==="
systemctl enable --now puppet

echo "=== Estado final ==="
systemctl is-active puppetserver
systemctl is-enabled puppetserver
systemctl is-active puppet
systemctl is-enabled puppet

echo "=== Aprovisionamiento de Puppet terminado ==="

