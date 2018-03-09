class profile::ccs::demosubsystem {

   include profile::ccs::ccs
   include profile::ccs::installscript
   include profile::ccs::java

   file { '/lsst/ccsadmin/package-lists/ccsApplications.txt' :
     ensure => file, 
     content => "[ccs]\norg-lsst-ccs-subsystem-demo-main = 5.0.5\norg-lsst-ccs-subsystem-demo-gui = 5.0.5\nexecutable.RunDemoSubsystem = org-lsst-ccs-subsystem-demo-main\nexecutable.RunDemoSubsystem = org-lsst-ccs-subsystem-demo-main\nexecutable.CCS_Console = org-lsst-ccs-subsystem-demo-gui\nexecutable.ShellCommandConsole = org-lsst-ccs-subsystem-demo-gui\n",
   }	

   exec { 'doit': 
     command => '/lsst/ccsadmin/release/bin/install.py --ccs_inst_dir /lsst/ccs/prod /lsst/ccsadmin/package-lists/ccsApplications.txt', 
   }

   file { '/lib/systemd/system/demoSubsystemService.service':
     mode    => '0644',
     owner   => 'root',
     group   => 'root',
     content => epp('profile/ccs/service.epp', { 'serviceName' => 'DemoSubsystemService', 'serviceCommand' => '/lsst/ccs/prod/bin/RunDemoSubsystem'}),
   }
   
   exec { 'demoSubsystemService-systemd-reload':
     command     => 'systemctl daemon-reload',
     path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
     refreshonly => true,   
   } 

   service { 'demoSubsystemService':
     ensure => running,
     enable => true,
   }
	          
}
