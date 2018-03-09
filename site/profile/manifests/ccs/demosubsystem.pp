class profile::ccs::demosubsystem {

   class {'subsystem':
      subsystemName => "demo",
      version = '5.0.5',
      command = 'RunDemoSubsystem',
      service = 'demoSubsystemService'
   }
	          
}
