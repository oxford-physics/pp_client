class pp_client::tunenfs(  ) { 

#hosts_allow {$process: }

define pp_client::tunenfs() {
 #if $ensure == 'present' {
   augeas { "tunenfs":
   context => "/files/etc/sysctl.conf",
   changes => "set [. = /net.core.wmem_max] 2191361",
  }
 #} 
#else {
#   augeas { "Add ${name} to ${process}":
 #  context => "/files/etc/hosts.allow",
  # changes => ["set last()+1  ${process}", "set 2/client {$name}",]
   #}
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
