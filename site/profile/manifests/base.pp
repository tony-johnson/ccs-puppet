class profile::base {
  class { '::ntp': }
  class { 'profile::java' }
  class { 'profile::demosubsystem' }
}

