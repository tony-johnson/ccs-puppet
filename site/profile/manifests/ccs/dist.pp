#
# Installs a single CCS dist file, and creates shortcuts
#
class profile::ccs::dist (String $distfile, String $version, $commands = []) {

   include profile::ccs::ccs
   include profile::ccs::installscript
   include profile::ccs::java

   file { "/lsst/ccsadmin/package-lists/${distfile}.txt":
     ensure => file,
     content => "[ccs]\n${distfile} = ${version}"
   }->
   $commands.each |String $command| {
     file-line { "append":
        path => "/lsst/ccsadmin/package-lists/${distfile}.txt",
        line => "executable.${command} = ${distfile}
     }
   }

   exec { 'doit':
     command => "/lsst/ccsadmin/release/bin/install.py --ccs_inst_dir /lsst/ccs/prod /lsst/ccsadmin/package-lists/${distfile}.txt"
   }

}
