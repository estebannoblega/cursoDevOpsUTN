
# Directorio para las claves de repositorios APT
file { '/usr/share/keyrings':
  ensure => directory,
  owner  => 'root',
  group  => 'root',
  mode   => '0755',
}

# Descargar la clave oficial de Jenkins LTS
exec { 'download-jenkins-key':
  command => '/usr/bin/curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key -o /usr/share/keyrings/jenkins-keyring.asc',
  creates => '/usr/share/keyrings/jenkins-keyring.asc',
  require => File['/usr/share/keyrings'],
}

# Gestionar los permisos de la clave
file { '/usr/share/keyrings/jenkins-keyring.asc':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  require => Exec['download-jenkins-key'],
}

# Registrar el repositorio LTS de Jenkins
file { '/etc/apt/sources.list.d/jenkins.list':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/\n",
  require => File['/usr/share/keyrings/jenkins-keyring.asc'],
}

# Actualizar índices cuando cambien la clave o el repositorio
exec { 'apt-get-update-jenkins':
  command     => '/usr/bin/apt-get update',
  refreshonly => true,
  subscribe   => [
    Exec['download-jenkins-key'],
    File['/etc/apt/sources.list.d/jenkins.list'],
  ],
}

# Dependencias de Jenkins
package { 'fontconfig':
  ensure  => installed,
  require => Exec['apt-get-update-jenkins'],
}

package { 'openjdk-21-jre':
  ensure  => installed,
  require => Exec['apt-get-update-jenkins'],
}

# Instalar Jenkins LTS
package { 'jenkins':
  ensure  => installed,
  require => [
    Package['fontconfig'],
    Package['openjdk-21-jre'],
    Exec['apt-get-update-jenkins'],
  ],
}

# Habilitar e iniciar el servicio
service { 'jenkins':
  ensure  => running,
  enable  => true,
  require => Package['jenkins'],
}

