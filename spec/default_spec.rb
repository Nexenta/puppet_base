
require 'spec_helper'

describe 'default manifest' do

  before :each do
    %x[ touch "/root/.ssh/authorized_keys" ] unless File.exist?( '/root/.ssh/auithorized_keys' )

    # /kernel/drv/scsi_vhci.conf
    # /etc/inet/ntp.conf
    # /etc/default/nfs

  end

  it 'services' do
    ;
  end

  it 'files' do
    @olds = [ '/etc/nsswitch.conf', '/etc/resolv.conf', '/root/.ssh/authorized_keys', '/etc/system', '/etc/logadm.conf', '/etc/syslog.conf',
              '/etc/default/nfs', '/kernel/drv/scsi_vhci.conf', '/etc/inet/ntp.conf' ]
    @olds.each { |old| File.rename old, "#{old}-old" }
    @olds.each { |old| File.exist?( old ).should eql false }

    @un_olds = files_that_otherwise_do_not_exist = [ '/etc/snmp/snmpd.conf' ]
    @un_olds.each { |p| File.exist?( p ).should eql false }

    %x[ puppet agent --test ]

    @olds.each do |old|
      File.exist?( old ).should eql true
      File.delete( old )
      File.rename "#{old}-old", old
    end
    
    @un_olds.each do |p|
      File.exist?( p ).should eql true
      File.delete( p )
    end
  end

end


