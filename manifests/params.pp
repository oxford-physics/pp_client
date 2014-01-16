class pp_client::params ( 
    $autodatalocation=hiera("pp_client::params::autodatalocation", "puppet:///modules/$module_name/auto.pplxfs" ),
    $autohomelocation=hiera("pp_client::params::autohomelocation", "puppet:///modules/$module_name/auto.home"),
) 
{

}
