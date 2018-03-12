class profile::ccs::subsystem (String $subsystemName, String $version, String $command, String $service) {

   profile::ccs::dist { 'main':
      distfile => "org-lsst-ccs-subsystem-${subsystemName}-main",
      version => $version,
      commands => [$command],
   }

   profile::ccs::dist { 'gui':
      distfile => "org-lsst-ccs-subsystem-${subsystemName}-gui",
      version => $version,
      commands => ["CCS-Console", "ShellCommandConsole"],
   }

   file { "/lib/systemd/system/${service}.service":
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
