class pp_client::tunenfs(  ) { 

define pp_client::tunenfs() {
   augeas { "tunenfs":
   context => "/files/etc/sysctl.conf",
   changes => "set [. = /net.core.wmem_max] 2191361",
  }
 }

  file { '/etc/sysconfig/nfs' :
     ensure => 'present',
     source => "puppet:///modules/$module_name/sysconfig.nfs",
     require => Package['nfs-utils'],
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      notify => Service['nfs']
     }

}
