# The NFS mount define for the RedHat/CentOS OSes

define nfs::mount::redhat (
    $source,
    $dest,
    $type   = 'nfs',
    $opts   = 'nofail,defaults',
    $dump   = 0,
    $passno = 0) {

  $dest_dirtree = dirtree($dest)
  ensure_resource( 'file', $dest_dirtree, { ensure => directory })

  $fstab_changes = [
    "set 01/spec ${source}",
    "set 01/file ${dest}",
    "set 01/vfstype ${type}",
    "set 01/dump ${dump}",
    "set 01/passno ${passno}",
  ]

  concat($fstab_changes, nfs_augeas_opts($opts))

  augeas { "Create mount from '${source}' to ${dest}":
    context => '/files/etc/fstab',
    changes => $fstab_changes,
    onlyif  => "match *[spec='${source}' and file='${dest}'] size == 0",
    notify  => Exec["/bin/mount ${dest}"],
    require => File[$dest_dirtree],
  }

  $opts_array = prefix(split($opts, ','), "${source},${dest},")
  nfs::mount::fstab_options { $opts_array:
    source  => $source,
    dest    => $dest,
    require => Augeas["Create mount from '${source}' to ${dest}"],
    before  => Exec["/bin/mount ${dest}"],
  }

  exec { "/bin/mount ${dest}":
    unless  => "/bin/mount | /bin/grep '${dest}'",
    require => [ File[$dest_dirtree], Service['nfs::rpcbind'] ],
  }

}
