include_recipe "apt"

apt_repository "node.js" do
  uri "http://ppa.launchpad.net/chris-lea/node.js/ubuntu"
  distribution node['lsb']['codename']
  components ['main']
  keyserver "keyserver.ubuntu.com"
  key "C7917B12"
  action :add
end

%w{ nodejs npm }.each do |p|
  package p
end
