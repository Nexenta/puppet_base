
class puppet_base {

  #
  # variables
  #

  $timeservers = [ '0.pool.ntp.org', '1.pool.ntp.org' ]
  $snmp = { rocommunity => 'public',
    sysDescr => 'NexentaOS',
    sysLocation => '', 
    sysContact => 'youremail@me.com', 
    trapsink => 'localhost', 
    linkUpDownNofitications => 'yes', 
    master => 'agentx', 
    extends => [],
  }
  $nameservers = [ '10.2.3.4', '10.2.3.5' ]
  $resolv_search = 'mgt.yourcompany.net prd.yourcompany.net'
  $domainname = $hostname
  $loghosts = [ 'loghost1', 'loghost2' ]

  # defaults -- except nfs_server_versmax where default is 4,
  # and nfs_client_versmax where default is 4
  $nfs = { nfsd_listen_backlog => '64', 
    nfsd_protocol => 'ALL', 
    nfsd_servers => '1024', 
    lockd_listen_backlog => '64', 
    lockd_servers => '1024', 
    lockd_retransmit_timeout => '5', 
    grace_pediod => '90', 
    nfs_server_versmax => '3', 
    nfs_client_versmax => '3',
  }
  $zfs_resilver_delay = '2' # default
  $zfs_txg_synctime_ms = '5000' # default
  $zfs_txg_timeout = '10' # default

  # non-default
  $system_extra = { swapfs_minfree => '1048576',
    'zfs:l2arc_write_boost' => '83886080',
  } 
  $authorized_keys = [ 'ssh-dss AAAA...== joe', 'ssh-dss AAAnasdfg...= jane' ]

  $nms = { ses_check_flapping_default => '2', # between 0 and 9.
    ses_check_flapping_current => '0',
    nms_reporter_default => 'disable',
    nms_reporter_current => 'enable',
  }
  $logadm = { mnv_log_rotate_default => '10m', # must be in the XXm format.
    nmv_log_totate_current => 0
  }
  

  #
  # ///// exec ///// 
  #

  exec { 'restart_ntp':
    command => 'svcadm refresh ntp',
    path => [ '/usr/bin', '/bin/', '/sbin', '/usr/sbin' ],
    refreshonly => true,
  }

  exec { 'restart_snmp':
    command => 'svcadm disable snmpd; svcadm enable snmpd',
    path => [ '/usr/bin', '/bin/', '/sbin', '/usr/sbin' ],
    refreshonly => true,
  }

  exec { 'restart_syslog':
    command => 'svcadm refresh system-log',
    path => [ '/usr/bin', '/bin/', '/sbin', '/usr/sbin' ],
    refreshonly => true,
  }

  exec { 'load_nfs_config':
    command => 'perl -e "use NZA::Common;
                      &NZA::netsvc->reread_config(\'svc:/network/nfs/server:default\');
                      &NZA::netsvc->restart(\'svc:/network/nfs/server:default\');" ',
    path => [ '/usr/bin', '/bin/', '/sbin', '/usr/sbin' ],
    refreshonly => true,
  }

  exec { 'enable_nfs':
    command => 'perl -e "use NZA::Common;
                      &NZA::netsvc->enable(\'svc:/network/nfs/server:default\');" ',
    onlyif => $is_nfs_disabled,
    path => [ '/usr/bin', '/bin/', '/sbin', '/usr/sbin' ],
    refreshonly => true,
  }

  exec { 'ses_check_flapping':
    command => "nmc -c \" setup trigger ses-check property inval_anti_flapping -p ${nms['ses_check_flapping_default']} -y \";
                touch /etc/puppet/touchfiles/donerun_ses_check_flapping ",
    path => [ '/usr/bin', '/bin/', '/sbin', '/usr/sbin' ],
    creates => '/etc/puppet/touchfiles/donerun_ses_check_flapping',
    refreshonly => true,
  }

  exec { 'change_nms_reporter':
    command => "nmc -c \"setup reporter ${nms['nms_reporter_default']} \";
                touch /etc/puppet/touchfiles/donerun_change_nms_reporter ",
    path => [ '/usr/bin', '/bin/', '/sbin', '/usr/sbin' ],
    creates => '/etc/puppet/touchfiles/donerun_change_nms_reporter',
    refreshonly => true,
    logoutput => on_failure,
  }

  #
  # ///// files /////
  #

  file { '/etc/nsswitch.conf':
    path => '/etc/nsswitch.conf',
    ensure => present,
    mode => '0644',
    owner => 'root',
    group => 'sys',
    source => 'puppet:///modules/puppet_base/nsswitch.conf',
  }

  file { '/etc/resolv.conf':
    ensure => present,
    mode => '0644',
    owner => 'root',
    group => 'sys',
    content => template('puppet_base/resolv.conf.erb'),
  }
  
  # notify { "hardware platform ${hardware_platform}": }
  # notify { "nexenta version ${nexenta_version}": }
  # notify { "memory in megabytes ${memory_in_megabytes}": }

}
