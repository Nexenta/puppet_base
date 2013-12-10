
class puppet_base {
  # get current nexentastor version

  # custom plugin, memory

  # custom facter plugin for nexenta ( should include version of nexenta-stor )

  # nothing - command for restarting ntp
  # nothing - command for restarting syslog
  # nothing - command for restarting snmp

  # perl command to re-read nfs config

  file { '/etc/nsswitch.conf':
    path: '/etc/nsswitch.conf',
    ensure: file,
    mode: 0644,
    owner: root,
    group: sys,
    source: 'puppet:///modules/puppet_base/nsswitch.conf',
  }

  file { '/etc/resolv.conf':
    ensure: file,
    mode: 0644,
    owner: root,
    group: sys,
    source: 'puppet:///modules/puppet_base/resolv.conf.erb',
  }

  file { '/kernel/drv/scsi_vhci.conf':
    ensure: file,
    mode: 0600,
    group: sys,
    owner: root,
    source: 'puppet:///modules/puppet_base/scsi_vhci.conf',
  }

  file { '/etc/syslog.conf':
    ensure: file,
    source: 'puppet:///modules/puppet_base/syslog.conf.erb',
    owner: root,
    group: sys,
    mode: 0644,
    # variables,
    # notifies,
  }

  file { '/etc/inet/ntp.conf':
    ensure: file,
    source: 'puppet:///modules/puppet_base/ntp.conf.erb',
    owner: root,
    group: sys,
    mode: 0644,
    # variables,
    # notifies,
  }
   
  file { '/etc/snmp/snmpd.conf':
    ensure: file,
    source: 'puppet:///modules/puppet_base/snmpd.conf.erb',
    owner: root,
    group: root,
    mode: 0644,
    # variables,
    # notifies,
  }

  file { '/etc/default/nfs': 
    ensure: file,
    source: 'puppet:///modules/puppet_base/nfs.erb',
    owner: root,
    group: root,
    mode: 0444,
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

  # this is a template
  file { '/etc/system':
    path: '/etc/system',
    ensure: file,
    mode: 0755,
    owner: root,
    group: root,
    source': 'puppet:///modules/puppet_base/nsswitch.conf',
    # variables: version => current
  }

  file { '/root/.ssh/authorized_keys':
    'path': '/root/.ssh/authorized_keys',
    'ensure': '',
    'mode': '0600',
    'owner': 'root',
    'group': 'root',
    'source': 'puppet:///modules/puppet_base/nsswitch.conf',
    # variables: version => current

    # if node[:nexenta].attribute?("partners")
    #   hostname = node[:nexenta][:partners].split(".")[0]
    #   allnodes = Chef::REST.new(Chef::Config[:chef_server_url]).get_rest("nodes")
    #   variables(
    #     :partner => Chef::REST.new(Chef::Config[:chef_server_url]).get_rest("nodes/#{allnodes.select {|e| e =~ /#{hostname}/}.keys[0]}") || ""
    #   )
    # end
  }

}