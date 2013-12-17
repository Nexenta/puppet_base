
require 'spec_helper'

describe 'presence of various blocks in the manifest' do

  before :each do
    ;
  end

  it 'has various blocks in the manifest' do
    manifest = File.read( './manifests/init.pp' )
    puts '+++ +++'
    puts manifest.inspect
  end

end
