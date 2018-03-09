class profile::base {
  class { '::ntp': }
  class { 'profile::ccs::demosubsystem': }
}

