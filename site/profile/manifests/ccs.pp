class profile::ccs {
   file { ['/lsst', '/lsst/ccs', '/lsst/ccsadmin', '/lsst/ccsadmin/package-lists', '/var/log/ccs', '/etc/ccs' ] : 
      ensure => directory,
      mode => '1764',
   }

   user { 'ccs':
      ensure => present,
      managehome => true,
   } 
}
