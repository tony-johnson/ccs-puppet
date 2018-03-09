class profile::ccs::base {
  class { '::ntp': }
  class { 'profile::ccs::demosubsystem': }
}

