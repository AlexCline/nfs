# This manifest includes tests for the NFS module.

nfs { 'Test NFS mount':
  source => 'netapp1b:/vol/voldata/releases',
  dest   => '/a/path/to/releases',
}

nfs { 'Another test NFS mount':
  source => 'netapp1b:/vol/voldata/candidates',
  dest   => '/a/second/path/to/candidates',
  type   => 'nfs',
  opts   => 'ro,defaults,noatime',
}

