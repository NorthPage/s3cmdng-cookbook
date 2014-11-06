#
# Cookbook Name:: s3cmdng
# Recipe:: config
#
# Author:: Camden Fisher (<camden@northpage.com>)
# Copyright (C) 2014 NorthPage
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

db_name = node['s3cmdng']['data_bag_name']
db_item = node['s3cmdng']['data_bag_item']

s3_creds = Chef::EncryptedDataBagItem.load(db_name, db_item)

s3_key = s3_creds["s3_access_key"]
s3_secret = s3_creds["s3_secret_key"]
users = node['s3cmdng']['users']
 
unless s3_creds.nil? 
  users.each do |u|
    unless node['etc']['passwd'][u].nil?
      template "#{node['etc']['passwd'][u]['dir']}/.s3cfg" do
        source "s3cfg.erb"
        owner u
        mode "0400"
        variables(
          :s3_access_key => s3_key,
          :s3_secret => s3_secret)
      end
    else
      Chef::Log.warn("Unable to configre s3cmd for user #{u}, not found")
    end
  end
else
  Chef::Log.warn("Unable to determine s3 creds")
end
