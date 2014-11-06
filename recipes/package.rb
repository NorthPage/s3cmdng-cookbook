#
# Cookbook Name:: s3cmdng
# Recipe:: package
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

case node['platform_family']
when "rhel"
  include_recipe 'yum-epel'
  package_list = ['s3cmd']
when "debian"
  package_list = ['python-magic', 's3cmd']
end

package_list.each do |p|
  package p do
    action [:install, :upgrade]
  end
end
