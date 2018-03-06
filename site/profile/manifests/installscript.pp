class profile::installscript {
   include profile::ccs

   package { 'git':
      ensure => present,
   }

   vcsrepo { '/lsst/ccsadmin/release':
     ensure   => present,
     provider => git,
     source   => 'https://github.com/lsst-camera-dh/release',
   }
}
