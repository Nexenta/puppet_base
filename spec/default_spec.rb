
require 'spec_helper'

describe 'default manifest' do

  before :each do
    %x[ touch "/root/.ssh/authorized_keys" ] unless File.exist?( '/root/.ssh/auithorized_keys' )
  end

  it 'files' do
    # /kernel/drv/scsi_vhci.conf

    # /etc/syslog.conf
    # /etc/inet/ntp.conf
    # /etc/snmp/snmpd.conf
    # /etc/default/nfs', 

    # heavy xfs config
    # /etc/system
  end

  it 'services' do
    ;
  end

  it 'files' do
    @olds = [ '/etc/nsswitch.conf', '/etc/resolv.conf', '/root/.ssh/authorized_keys', '/etc/system', '/etc/logadm.conf', '/etc/syslog.conf' ]

    @olds.each { |old| File.rename old, "#{old}-old" }

    @olds.each { |old| File.exist?( old ).should eql false }

    %x[ puppet agent --test ]

    @olds.each do |old|
      File.exist?( old ).should eql true
      File.delete( old )
      File.rename "#{old}-old", old
    end
  end

end


