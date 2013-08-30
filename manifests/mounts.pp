####Must be declared outside
class pp_client::mounts {

$nfsmountreqs =[ Package["nfs-utils"], Service["nfslock"],  Service["rpcbind"]]

#a virtual resource, as needed all over the place
@file { '/network' :
  ensure  => 'directory',
  mode    => '0744',
  owner   => 'root',
  group   => 'root',
  }

#Appears to be a common problem that puppet cant create a directory with the correct permissions only if it does not exist.
#When I mount this dir, the owner and perms change, so puppet cannot manage these except through facters I guess

 file { '/network/software' :
  ensure  => 'directory',
  replace => "no",
  require => File['/network'],
  }

  include nfsclient

  file { '/system' :
  ensure  => 'directory',
  mode    => '0744',
  owner   => 'root',
  group   => 'root',
  }

    realize(File["/network"])
  # realize(File["/network/software"])
  mount { "/network/software":
    device  => "cplxfs3:/srv/software/",
    fstype  => "nfs",
    ensure  => "mounted",
    options => "tcp,rsize=32768,wsize=32768,hard,intr,exec,dev,nosuid,rw,bg,acl",
    atboot  => "true",
    require => [File['/network/software'], $nfsmountreqs],
    }

  mount { "/home":
    device  => "pplxfs10:/home",
    fstype  => "nfs",
    ensure  => "mounted",
    options => "tcp,rsize=32768,wsize=32768,hard,intr,exec,dev,nosuid,rw,bg",
    atboot  => "true",
    require => [File['/system'], $nfsmountreqs],
    }


  mount { "/system":
    device  => "pplxfs10:/data/sharedsoftware",
    fstype  => "nfs",
    ensure  => "mounted",
    options => "tcp,rsize=8192,wsize=8192,hard,intr,exec,dev,nosuid,rw,bg",
    atboot  => "true", 
    require => $nfsmountreqs,
   }
  #mount { "/lustre/lhcb":
  #  device  => "pplxlustremds:/lustre/lhcb",
  #  fstype  => "lustre",
  #  ensure  => "mounted",
  #  options => "tcp,rsize=8192,wsize=8192,hard,intr,exec,dev,nosuid,rw,bg",
  #  atboot  => "true",
  #  require => File['/lustre/lhcb'],
  #  }
  #mount { "/lustre/atlas":
  #  device  => "pplxlustremds:/lustre/atlas",
  #  fstype  => "lustre",
  #  ensure  => "mounted",
  #  options => "tcp,rsize=8192,wsize=8192,hard,intr,exec,dev,nosuid,rw,bg",
  #  atboot  => "true",
  #  require => File['/lustre/atlas'],
  #  }

  #fstab augeas lens appars not to work when adding ( try it from augtool) 
  #It can change existing things though
       
#     augeas{"${file}_change":
#       context   => '/files/etc/fstab',
       #This part changes options on an already existing line

#       changes   =>     [
#                    "set *[spec=${spec}][file=${file}]/spec ${spec}",         
#                    "set *[spec=${spec}][file=${file}]/file ${file}",
#                    "set *[spec=${spec}][file=${file}]/opt tcp",
#                    "set *[spec=${spec}][file=${file}]/vfstype nfs",
#                    "set *[spec=${spec}][file=${file}]/dump 0",
#                    "set *[spec=${spec}][file=${file}]/passno 0"
#                  ],
#               onlyif => "match *[spec='$key'][file='$fname'] size != 0",
#
#     }

}
#class pp_client::lustremounts {

 # pplxlustremds:/lhcb       /lustre/lhcb/    lustre    localflock   0 0

#}
#######################################

