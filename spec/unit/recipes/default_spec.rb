require 'spec_helper'

describe 's3cmdng::default' do
  
  before(:each) do
    allow(Chef::EncryptedDataBagItem).to receive(:load).with('s3cmd', 's3cfg').and_return('s3cfg' => {
                                                                's3_access_key' => 'CHANGECHANGECHANGE',
                                                                's3_secret_key' => 'CHANGEMECHANGEMECHANGEME'})
  end
  
  platforms = {
    'centos' => ['6.6', '7.0'],
    'ubuntu' => ['14.04']
  }

  platform_pkgs = {
    'centos' => ['s3cmd'],
    'ubuntu' => ['s3cmd','python-magic']
  }

  platforms.each do |platform, versions|
    versions.each do |version|

      context "on #{platform.capitalize} #{version}" do
        let (:chef_run) do
          ChefSpec::SoloRunner.new(log_level: :error, platform: platform, version: version) do |node|
            # Set additional attributes here
            node.set['etc']['passwd']['root'] = { dir: '/root' }
          end.converge(described_recipe) 
        end
        
        it 'should include s3cmdng::package recipe by default' do
          expect(chef_run).to include_recipe 's3cmdng::package'
        end
        
        it 'should include s3cmdng::config recipe by default' do
          expect(chef_run).to include_recipe 's3cmdng::config'
        end
        
        platform_pkgs[platform].each do |p|
          it "installs #{p}" do
            expect(chef_run).to install_package(p)
          end
        end
        
        it 'should render the s3cfg' do
          expect(chef_run).to render_file('/root/.s3cfg')
        end
      end
    end
  end
end
