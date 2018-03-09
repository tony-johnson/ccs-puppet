class profile::ccs::java {
    java::oracle { 'jdk8' :
      ensure  => 'present',
      version_major => '8u161',
      version_minor => 'b12',
      url_hash => '2f38c3b165be4555a1fa6e98c45e0808',
      java_se => 'jdk',
      before => Exec['update-java-alternatives']
    }

    # Not clear why this is needed, but without it java is left pointing to openjdk
    exec { 'update-java-alternatives':
      path    => '/usr/bin:/usr/sbin',
      command => "alternatives --set java /usr/java/jdk1.8.0_161/jre/bin/java" ,
      unless  => "test /etc/alternatives/java -ef '/usr/java/jdk1.8.0_161/jre/bin/java'",
    }

    # Not strictly required by java, but graphical components will not run without it
    yum::group { 'X Window System':
       ensure  => present,
    }
}
