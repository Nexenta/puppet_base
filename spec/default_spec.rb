
require 'spec_helper'

describe 'default manifest' do

  before :each do
    ;
  end

  it 'files' do
    # file_list = [ '/kernel/drv/scsi_vhci.conf', '/etc/syslog.conf', '/etc/inet/ntp.conf', '/etc/snmp/snmpd.conf', '/etc/default/nfs', '/etc/system', '/root/.ssh/authorized_keys' ]
  end

  it 'services' do
    ;
  end

  it 'etc/nsswitch.conf, etc/resolv.conf' do
    olds = [ '/etc/nsswitch.conf', '/etc/resolv.conf' ]

    olds.each do |old|
      File.rename old, "#{old}-old"
    end

    %x[ puppet agent --test ]

    olds.each do |old|
      File.exist?( old ).should eql true
      File.delete( old )
      File.rename "#{old}-old", old
    end
  end

end


