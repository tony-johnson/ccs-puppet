class profile::java {
java::oracle { 'jdk8' :
  ensure  => 'present',
  version_major => '8u151',
  version_minor => 'b12',
  url_hash => 'e758a0de34e24606bca991d704f6dcbf' ,
  java_se => 'jdk', 
  before => Exec['update-java-alternatives']
}
# Not clear why this is needed, but without it java is left pointing to openjdk
exec { 'update-java-alternatives':
  path    => '/usr/bin:/usr/sbin',
  command => "alternatives --set java /usr/java/jdk1.8.0_151/jre/bin/java" ,
  unless  => "test /etc/alternatives/java -ef '/usr/java/jdk1.8.0_151/jre/bin/java'",
}

}
