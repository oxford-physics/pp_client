class pp_client::misc {

    file {'/etc/cron.hourly/passive_check_yumupdate' :
          source => "puppet:///modules/${module_name}/cron-passive_check_yumupdate",
          mode => 755,
          owner => root,
          group=>root,
          ensure=>present
    }
 } 
