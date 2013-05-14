# NFS resource
# This resource is for all the NFS clients

define nfs (
  $source,
  $dest,
  $type = 'nfs',
  $opts = 'defaults,noatime') {

  case $::operatingsystem {
    'RedHat', 'CentOS': {

      # Only define the dependencies once
      if ! defined( Service['nfs::rpcbind'] ) {
        include nfs::dependencies::redhat
      }

      nfs::mount::redhat { $name:
        source => $source,
        dest   => $dest,
        type   => $type,
        opts   => $opts,
      }
    }

    default: { warn('Your platform isn\'t supported by the NFS module.') }

  }
}
