#Hanlded elsewhere, so obsolete
class pp_client::misc {

    file {'/usr/local/bin/newnode-test.sh' :
          source => "puppet:///modules/${module_name}/newnode-test.sh",
          mode => 755,
          owner => root,
          group=>root,
          ensure=>present
    }
 } 
