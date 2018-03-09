class profile::ccs::demosubsystem {

   class {'profile::ccs::subsystem':
      subsystemName => "demo",
      version => '5.0.5',
      command => 'RunDemoSubsystem',
      service => 'demoSubsystemService'
   }
	          
}
