nfs
=======

*This module provides the NFS resource type which controls NFS mounts on linux systems.*

This module also includes the fstab_augeas_opts function which will return an
array of augeas compatible changes based on a comma-separated list of fstab opts.

Examples
--------

The NFS module can be instantiated using the following definitions:

    nfs { 'Test NFS mount':
      source => 'host.example.com:/data/releases',
      dest   => '/a/path/to/releases',
    }

    nfs { 'Another test NFS mount':
      source => 'host2.example.com:/data/candidates',
      dest   => '/a/second/path/to/candidates',
      type   => 'nfs',
      opts   => 'nofail,ro,defaults,noatime',
    }

The default opts defined for a mount are `nofail,defaults,noatime`.

To Do
-----

Code ensure => present/absent

Support
-------

Please file tickets and issues using [GitHub Issues](https://github.com/AlexCline/nfs/issues)


License
-------
   Copyright 2013 Alex Cline <alex.cline@gmail.com>

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

