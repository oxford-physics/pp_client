class pp_client::security {

  include "access::access_wrapper"
  ensure_packages ( ['fuse'] )
  file {'/bin/fusermount':
         require => Package ['fuse'],
         mode=>4750,
         owner=>root,
         group=>fuse,
         ensure=>present

        }
}
