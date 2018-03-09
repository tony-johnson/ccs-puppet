class profile::ccs::subsystem (String $subsystemName, String $version, String $command, String $service) {

   include profile::ccs::ccs
   include profile::ccs::installscript
   include profile::ccs::java

   file { '/lsst/ccsadmin/package-lists/ccsApplications.txt' :
     ensure => file,
     content => "[ccs]\norg-lsst-ccs-subsystem-${subsystemName}-main = ${version}\norg-lsst-ccs-subsystem-${subsystemName}-gui = ${version}\nexecutable.${command} = org-lsst-ccs-subsystem-demo-main\nexecutable.CCS-Console = org-lsst-ccs-subsystem-${subsystemName}-gui\nexecutable.ShellCommandConsole = org-lsst-ccs-subsystem-${subsystemName}-gui\n",
   }

   exec { 'doit':
     command => '/lsst/ccsadmin/release/bin/install.py --ccs_inst_dir /lsst/ccs/prod /lsst/ccsadmin/package-lists/ccsApplications.txt',
   }

   file { "lib/systemd/system/${service}.service":
     mode    => '0644',
     owner   => 'root',
     group   => 'root',
     content => epp('profile/ccs/service.epp', { 'serviceName' => 'DemoSubsystemService', 'serviceCommand' => '/lsst/ccs/prod/bin/${command}'}),
   }

   exec { 'systemd-reload':
     command     => 'systemctl daemon-reload',
     path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
     refreshonly => true,
   }

   service { "${service}":
     ensure => running,
     enable => true,
   }

}
