
class puppet_base {

  file { '/root/trashy':
    ensure => present,
    content => 'grokin it.\n',
  }

  # get current nexentastor version

  # custom plugin, memory

  # custom facter plugin for nexenta ( should include version of nexenta-stor )

  # nothing - command for restarting ntp
  # nothing - command for restarting syslog
  # nothing - command for restarting snmp

  # perl command to re-read nfs config

  file { '/etc/nsswitch.conf':
    path => '/etc/nsswitch.conf',
    ensure => present,
    mode => '0644',
    owner => 'root',
    group => 'sys',
    source => 'puppet:///modules/puppet_base/nsswitch.conf',
  }

  # @TODO this should be documented and placed somewhere else.
  $nameservers = [ '10.2.3.4', '10.2.3.5' ]

  # @TODO document and move this elsewhere?
  $resolv_search = 'mgt.yourcompany.net prd.yourcompany.net'

  # @TODO
  $domainname = $hostname

  file { '/etc/resolv.conf':
    ensure => present,
    mode => '0644',
    owner => 'root',
    group => 'sys',
    content => template('puppet_base/resolv.conf.erb'),
  }

  # okk
  file { '/kernel/drv/scsi_vhci.conf':
    ensure => present,
    mode => '0644',
    group => 'sys',
    owner => 'root',
    source => 'puppet:///modules/puppet_base/scsi_vhci.conf',
  }

  # @TODO move
  $loghosts = [ 'loghost1', 'loghost2' ]

  # okk
  file { '/etc/syslog.conf':
    ensure => present,
    content => template('puppet_base/syslog.conf.erb'),
    owner => 'root',
    group => 'sys',
    mode => '0644',
  }

  # @TODO move
  $timeservers = [ '0.pool.ntp.org', '1.pool.ntp.org' ]

  # okk
  file { '/etc/inet/ntp.conf':
    ensure => present,
    content => template('puppet_base/ntp.conf.erb'),
    owner => 'root',
    group => 'sys',
    mode => '0644',
  }

  # @TODO move
  $snmp = { rocommunity => 'public', sysDescr => 'NexentaOS', sysLocation => '', sysContact => 'youremail@me.com', trapsink => 'localhost', linkUpDownNofitications => 'yes', master => 'agentx', extends => [] }

  # okk
  file { '/etc/snmp/snmpd.conf':
    ensure => file,
    source => 'puppet:///modules/puppet_base/snmpd.conf.erb',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  file { '/etc/default/nfs': 
    ensure => file,
    source => 'puppet:///modules/puppet_base/nfs.erb',
    owner => 'root',
    group => 'root',
    mode => '0444',
    # variables,
    # notifies,
  }

  # block create_nmv_log_attribute

  # block nmv_log_rotate

  # block create_reporter_attribute

  # block change_nms_reporter

  # block create_ses_check_attribute

  # block ses_check_flapping

  # perl enable_nfs

  # @TODO change and move
  $version = '4.0.0'
  $zfs_resilver_delay = '2' # default
  $zfs_txg_synctime_ms = '5000' # default
  $zfs_txg_timeout = '10' # default
  $system_extra = { swapfs_minfree => '1048576', 'zfs:l2arc_write_boost' => '83886080' } # non-default

  file { '/etc/system':
    ensure => present,
    mode => '0755',
    owner => 'root',
    group => 'root',
    content => template('puppet_base/system.erb'),
  }

  # @TODO move
  @authorized_keys = [ 'ssh-dss AAAA...== joe', 'ssh-dss AAAnasdfg...= jane' ]
  file { '/root/.ssh/authorized_keys':
    path => '/root/.ssh/authorized_keys',
    ensure => present,
    mode => '0600',
    owner => 'root',
    group => 'root',
    content => template('puppet_base/authorized_keys.erb'),
  }

}