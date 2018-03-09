# Installs the CCS install script (install.py)
# Possible this should be replaced with a puppet module
# which replicates the same functionality.
class profile::ccs::installscript {
   include profile::ccs::ccs

   package { 'git':
      ensure => present,
   }

   package { 'wget':
      ensure => present,
   }

   package { 'unzip':
      ensure => present,
   }

   vcsrepo { '/lsst/ccsadmin/release':
     ensure   => present,
     provider => git,
     source   => 'https://github.com/lsst-camera-dh/release',
   }
}
