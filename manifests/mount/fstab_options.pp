# Set fstab options for the specified mount.
# This currently only works for RedHat and CentOS

define nfs::mount::fstab_options ($source = undef, $dest = undef) {
  $opts = split($name, ',')
  $opt = $opts[2]

  augeas { "Set opt for ${source} at ${dest} to ${opt}":
    context => "/files/etc/fstab/*[spec='${source}' and file='${dest}']",
    changes => [
      "ins opt after opt[last()]",
      "set opt[last()] ${opt}",
    ],
    onlyif => "match opt[.='${opt}'] size == 0",
  }
}

