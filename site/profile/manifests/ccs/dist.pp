#
# Installs a single CCS dist file, and creates shortcuts
#
define profile::ccs::dist (String $distfile, String $version, Array[String] $commands = []) {

   include profile::ccs::ccs
   include profile::ccs::installscript
   include profile::ccs::java

   file { "/lsst/ccsadmin/package-lists/${distfile}.txt":
     ensure => file,
     content => "[ccs]\n${distfile} = ${version}",
   }
   
   $commands.each |String $command| {
     file_line { "append_${command}":
        path => "/lsst/ccsadmin/package-lists/${distfile}.txt",
        line => "executable.${command} = ${distfile}",
     }
   }

   exec { "doit_${distfile}":
     command => "/lsst/ccsadmin/release/bin/install.py --ccs_inst_dir /lsst/ccs/prod /lsst/ccsadmin/package-lists/${distfile}.txt",
   }

}
