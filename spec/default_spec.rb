
require 'spec_helper'

describe 'default manifest' do

  before :each do
    @olds = [ '/etc/nsswitch.conf', '/etc/resolv.conf', '/root/.ssh/authorized_keys' ]
    @olds.each { |old| %x[ touch old ] }

  end

  it 'files' do
    # /kernel/drv/scsi_vhci.conf

    # ', '/etc/syslog.conf', '/etc/inet/ntp.conf', '/etc/snmp/snmpd.conf', '/etc/default/nfs', 

    # heavy xfs config
    # /etc/system
  end

  it 'services' do
    ;
  end

  it 'etc/nsswitch.conf, etc/resolv.conf' do
    

    @olds.each do |old|
      File.rename old, "#{old}-old"
    end

    %x[ puppet agent --test ]

    @olds.each do |old|
      File.exist?( old ).should eql true
      File.delete( old )
      File.rename "#{old}-old", old
    end
  end

end


