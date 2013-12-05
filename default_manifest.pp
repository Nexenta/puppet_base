
#
# copyright notice
# author
# maintainer
#

class nexenta_base {

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
    # @TODO change
    source: nsswitch.conf,
  }

  # file /etc/resolv.conf

  # file /kernel/drv/scsi_vhci.conf

  # file/etc/syslog.conf

  # file /etc/inet/ntp.conf

  # file /etc/snmp/snmpd.conf

  # file /etc/default/nfs

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
    source': 'nsswitch.conf',
    # variables: version => current
  }

  file { '/root/.ssh/authorized_keys':
    'path': '/root/.ssh/authorized_keys',
    'ensure': '',
    'mode': '0600',
    'owner': 'root',
    'group': 'root',
    'source': 'nsswitch.conf',
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