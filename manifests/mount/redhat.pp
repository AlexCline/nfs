# The NFS mount define for the RedHat/CentOS OSes

define nfs::mount::redhat (
    $source,
    $dest,
    $type,
    $opts,
    $dump   = 0,
    $passno = 0) {

  $dest_dirtree = dirtree($dest)
  ensure_resource( 'file', $dest_dirtree, { ensure => directory })


  # The ordering of the changes in augeas matters, so we'll build
  # the changes, step by step and concat them together.
  # The order is: spec, file, vfstype*, opt*, dump?, passno?
  $fstab_part_one = [
    "set 01/spec ${source}",
    "set 01/file ${dest}",
    "set 01/vfstype ${type}"
  ]

  $fstab_part_two = fstab_augeas_opts($opts)

  $fstab_part_three = [
    "set 01/dump ${dump}",
    "set 01/passno ${passno}",
  ]

  # Concat parts one and two into onetwo, then concat onetwo and three
  $fstab_parts_onetwo = concat($fstab_part_one, $fstab_part_two)
  $fstab_changes      = concat($fstab_parts_onetwo, $fstab_part_three)

  augeas { "Create mount from '${source}' to ${dest}":
    context => '/files/etc/fstab',
    changes => $fstab_changes,
    onlyif  => "match *[spec='${source}' and file='${dest}'] size == 0",
    notify  => Exec["/bin/mount ${dest}"],
    require => File[$dest_dirtree],
  }

  exec { "/bin/mount ${dest}":
    unless  => "/bin/mount | /bin/grep '${dest}'",
    require => [ File[$dest_dirtree], Service['nfs::rpcbind'] ],
  }

}
