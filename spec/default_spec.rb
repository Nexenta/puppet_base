
require 'spec_helper'

describe 'default manifest' do

  before :each do
    ;
  end

  it 'sanity' do
    true.should eql true
  end

  it 'files' do
    file_list = [ '/etc/nsswitch.conf', '/etc/resolv.conf', '/kernel/drv/scsi_vhci.conf', '/etc/syslog.conf', '/etc/inet/ntp.conf',
                  '/etc/snmp/snmpd.conf', '/etc/default/nfs', '/etc/system', '/root/.ssh/authorized_keys' ]
    file_list.each { |f| File.delete( f ) if File.exist?( f ) }
    %x[ puppet agent --test ]
    file_list.each { |f| File.exist?( f ).should eql true }
  end

  it 'services' do
    ;
  end

end


