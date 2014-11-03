#merged into usernode policy group, so obsolete
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


  include nfsclient
  realize(File["/network"])

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

