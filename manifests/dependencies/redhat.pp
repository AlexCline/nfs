# The dependencies class for RedHat and CentOS

class nfs::dependencies::redhat {
  if ! defined( Package['nfs-utils'] ) { package { 'nfs-utils': ensure => installed } }
  if ! defined( Package['rpcbind'] )   { package { 'rpcbind':   ensure => installed } }

  service { 'nfs::rpcbind':
    ensure  => running,
    enable  => true,
    name    => 'rpcbind',
    require => Package['nfs-utils'],
  }

}
