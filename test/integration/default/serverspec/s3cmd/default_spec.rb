require 'spec_helper'

describe package('s3cmd') do
  it { should be_installed }
end

describe file('/root/.s3cfg') do
  it { should be_file }
  it { should be_mode 400 }
  it { should be_owned_by 'root' }
  its(:content) { should match /access_key = CHANGECHANGECHANGE/ }
  its(:content) { should match /secret_key = CHANGEMECHANGEMECHANGEME/ }
end

describe file('/home/vagrant/.s3cfg') do
  it { should be_file }
  it { should be_mode 400 }
  it { should be_owned_by 'vagrant' }
  its(:content) { should match /access_key = CHANGECHANGECHANGE/ }
  its(:content) { should match /secret_key = CHANGEMECHANGEMECHANGEME/ }
end
