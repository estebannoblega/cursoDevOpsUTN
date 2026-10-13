
#!/bin/bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive
export PATH="/opt/puppetlabs/bin:$PATH"

PUPPET_SERVER="utn-devops.localhost"
PUPPET_AGENT="agent.utn-devops.localhost"
MANIFEST_SOURCE="/vagrant/puppet/manifests/site.pp"
MANIFEST_DEST="/etc/puppetlabs/code/environments/production/manifests/site.pp"

echo "=== Actualizando paquetes ==="
apt-get update
apt-get install -y ca-certificates curl wget

echo "=== Instalando repositorio de Puppet 7 ==="
wget -q https://apt.puppet.com/puppet7-release-jammy.deb \
  -O /tmp/puppet7-release-jammy.deb
dpkg -i /tmp/puppet7-release-jammy.deb
apt-get update

echo "=== Instalando Puppet Server ==="
apt-get install -y puppetserver

echo "=== Configurando memoria de Puppet Server ==="
if grep -q '^JAVA_ARGS=' /etc/default/puppetserver; then
  sed -i 's/^JAVA_ARGS=.*/JAVA_ARGS="-Xms512m -Xmx512m"/' \
    /etc/default/puppetserver
else
  echo 'JAVA_ARGS="-Xms512m -Xmx512m"' >> /etc/default/puppetserver
fi

echo "=== Configurando identidad de Puppet ==="
install -d -m 0755 /etc/puppetlabs/puppet

cat > /etc/puppetlabs/puppet/puppet.conf <<EOF
[main]
certname = ${PUPPET_AGENT}
server = ${PUPPET_SERVER}
environment = production
runinterval = 30m

[server]
certname = ${PUPPET_SERVER}
dns_alt_names = ${PUPPET_SERVER},localhost
autosign = /etc/puppetlabs/puppet/autosign.conf
EOF

echo "${PUPPET_AGENT}" > /etc/puppetlabs/puppet/autosign.conf
chmod 0644 /etc/puppetlabs/puppet/autosign.conf

echo "=== Comprobando usuario y grupo de Puppet ==="
getent group puppet >/dev/null || groupadd --system puppet

if ! id puppet >/dev/null 2>&1; then
  useradd --system --gid puppet --home-dir /var/lib/puppet \
    --create-home --shell /usr/sbin/nologin puppet
fi

echo "=== Preparando el manifiesto ==="
test -f "${MANIFEST_SOURCE}"
install -d -m 0755 "$(dirname "${MANIFEST_DEST}")"
install -m 0644 "${MANIFEST_SOURCE}" "${MANIFEST_DEST}"

echo "=== Habilitando Puppet Server ==="
systemctl enable --now puppetserver

echo "=== Esperando a Puppet Server ==="
for i in $(seq 1 60); do
  if curl -ks "https://localhost:8140/" >/dev/null; then
    break
  fi
  sleep 2
done

if ! curl -ks "https://localhost:8140/" >/dev/null; then
  echo "ERROR: Puppet Server no respondió en el puerto 8140"
  systemctl status puppetserver --no-pager || true
  exit 1
fi

echo "=== Ejecutando agente de Puppet ==="
puppet agent --test --server "${PUPPET_SERVER}"

echo "=== Habilitando agente de Puppet ==="
systemctl enable --now puppet

echo "=== Verificando servicios ==="
systemctl is-active puppetserver
systemctl is-enabled puppetserver
systemctl is-active puppet
systemctl is-enabled puppet

echo "=== Aprovisionamiento de Puppet terminado ==="

