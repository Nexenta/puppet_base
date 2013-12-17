
require 'spec_helper'

describe 'presence of various blocks in the manifest' do

  before :each do
    ;
  end

  it 'has various blocks in the manifest' do
    manifest = File.read( './manifests/init.pp' )
    
    exec_block_names = [ 'restart_ntp', 'restart_syslog', 'restart_snmp', 'load_nfs_config', 'nmv_log_rotate', 'change_nms_reporter', 'ses_check_flapping', 'enable_nfs' ]

    exec_block_names.each do |p|
      manifest.include?( p ).should eql true
    end
  end

end
