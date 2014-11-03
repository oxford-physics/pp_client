#A bit crap, replace with something better for central ->pp merge
class pp_client::local_datadirs ( 
$autohomelocation = $pp_client::params::autohomelocation,
$autodatalocation = $pp_client::params::autodatalocation
) inherits pp_client::params{

  $this_profile = "$module_name"
  ensure_packages ( ['nfs-utils'] )

  #package structure
  $package_list = [ 'autofs' ]

  package { $package_list:
    ensure => installed,
  }
    service { 'nfs':
    name       => 'nfs',
    ensure     => stopped,
    enable     => false,
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
      source  => $autodatalocation,
      require => Package['autofs'],
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
  }

 file { '/etc/auto.home':
      ensure  => present,
      source  => $autohomelocation,
      require => Package['autofs'],
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
  }
 file { '/network/home':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
  }

  $map = '/etc/auto.pplxfs'
  $options_keys =['--timeout', '-g' ]
  $options_values  =[ '-120','']
  $dir = '/data'

     case $::augeasversion {
       '0.9.0','0.10.0','1.0.0': { $lenspath = '/var/lib/puppet/lib/augeas/lenses' }
        default: { $lenspath = undef }
     }
   $autofs_defaults = {
   'autofs' => {   'ensure'     => running,
               'hasstatus'  => true,
               'hasrestart' => true,
               'enable'     => true,
               'require'    => [Package['autofs']],
               'name' => 'autofs'
               }
    }
 
 
   if ! defined(Service['autofs']) {
       create_resources("service",  $autofs_defaults )
   }

 #Pattern based on     
 #http://projects.puppetlabs.com/projects/1/wiki/puppet_augeas

     augeas{"home_edit":

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
     augeas{"home_change":
       context   => '/files/etc/auto.master/',
       load_path => $lenspath,
       #This part changes options on an already existing line
       changes   => [
             "set 01   /network/home",
             "set 01/map  /etc/auto.home",
             "set 01/opt[1] ${options_keys[0]}",
             "set 01/opt[1]/value ${options_values[0]}",
             "set 01/opt[2] ${options_keys[1]}",
    #         "set 01/opt[2]/value ${options_values[1]}",
        ]   ,
       onlyif    => "match *[map='/etc/auto.home'] size == 0",

       notify    => Service['autofs']
     }
#######################################

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

