#
# Cookbook Name:: node
# Recipe:: source
#
# Copyright 2011, Tikibooth Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"
include_recipe "git"

case node[:platform]
  when "centos","redhat","fedora"
    package "openssl-devel"
  when "debian","ubuntu"
    package "libssl-dev"
end

git "/opt/node-src" do
  repo "https://github.com/joyent/node.git"
  revision node[:node][:version]
  notifies :run, "bash[compile_nodejs_source]", :immediately
end

bash "compile_nodejs_source" do
  cwd "/opt/node-src/"
  code <<-EOH
    ./configure && make -j#{node[:cpu][:total]} && make install && git rev-parse HEAD > /usr/local/share/node-version
  EOH
  not_if '[ -f /usr/local/share/node-version ] && [ "$(git rev-parse HEAD)" = "$(cat /usr/local/share/node-version)" ]', :cwd => "/opt/node-src"
end

