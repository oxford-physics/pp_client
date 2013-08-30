class pp_client::local_datadirs {

  $this_profile = "$module_name"
  ensure_packages ( ['nfs-utils'] )

  #package structure
  $package_list = [ 'autofs' ]

  package { $package_list:
    ensure => installed,
  }
    service { 'nfs':
    name       => 'nfs',
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require => Package['nfs-utils']
  }
    service { 'rpcbind':
    name       => 'rpcbind',
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require => Package['nfs-utils']
  }

    service { 'nfslock':
    name       => 'nfslock',
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require => Package['nfs-utils']
  }
#chkconfig nfslock on
 file { '/etc/auto.pplxfs':
      ensure  => present,
      source  => "puppet:///modules/$this_profile/auto.pplxfs",
      require => Package['autofs'],
      owner   => 'root',
      group   => 'root',
      mode    => '0400',
  }



  $map = '/etc/auto.pplxfs'
  $options_keys =['--timeout', '-g' ]
  $options_values  =[ '-120','']
  $dir = '/data'

     case $::augeasversion {
       '0.9.0','0.10.0': { $lenspath = '/var/lib/puppet/lib/augeas/lenses' }
        default: { $lenspath = undef }
     }

 #Pattern based on     
 #http://projects.puppetlabs.com/projects/1/wiki/puppet_augeas

     augeas{"${dir}_edit":

       context   => '/files/etc/auto.master/',

       load_path => $lenspath,
       #This part changes options on an already existing line

      changes   => [
             "set *[map = '$map']     $dir",
             "set *[map = '$map']/map  $map",
             "set *[map = '$map']/opt[1] ${options_keys[0]}",
             "set *[map = '$map']/opt[1]/value ${options_values[0]}",
             "set *[map = '$map']/opt[2] ${options_keys[1]}",
     #        "set *[map = '$map']/opt[2]/value ${options_values[1]}",
        ]   ,
       notify    => Service['autofs']
     }
     augeas{"${dir}_change":
       context   => '/files/etc/auto.master/',
       load_path => $lenspath,
       #This part changes options on an already existing line
       changes   => [
             "set 01   /data",
             "set 01/map  /etc/auto.pplxfs",
             "set 01/opt[1] ${options_keys[0]}",
             "set 01/opt[1]/value ${options_values[0]}",
             "set 01/opt[2] ${options_keys[1]}",
    #         "set 01/opt[2]/value ${options_values[1]}",
        ]   ,
       onlyif    => "match *[map='/etc/auto.pplxfs'] size == 0",

       notify    => Service['autofs']
     }
}
#######################################

