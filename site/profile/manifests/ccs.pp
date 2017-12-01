class profile::ccs {
   file { '/var/log/ccs' : 
      ensure => directory,
      mode => '1764',
      owner => ccs, 
      group => ccs,
   }

   file { ['/lsst', '/lsst/ccs', '/lsst/ccsadmin', '/lsst/ccsadmin/package-lists', '/etc/ccs' ] : 
      ensure => directory,
      mode => '1764',
   }

   file { '/etc/ccs/ccsGlobal.properties' :
      ensure => file,
      mode => '1764',
      content => epp('profile/ccsGlobal.properties.epp'),       
   }   

   file { '/etc/ccs/udp_ccs.properties' :
      ensure => file,
      mode => '1764',
      content => epp('profile/udp_ccs.properties.epp'),       
   }   

   user { 'ccs':
      ensure => present,
      managehome => true,
   } 
}
