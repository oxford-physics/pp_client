class pp_client::remote_connection {
   ensure_packages ([ "xrdp", "tigervnc-server"]  )
   service { "xrdp" :
    name       => 'xrdp',
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require => Package['xrdp']
  }

}
