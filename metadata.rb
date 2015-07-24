maintainer       "Tikibooth Limited"
name             "node"
maintainer_email "devops@butter.com.hk"
license          "Apache 2.0"
description      "Installs/Configures node, npm and node server providers"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.10"

%w{ubuntu debian}.each do |os|
  supports os
end

%w{git apt runit build-essential}.each do |dep|
  depends dep
end

attribute "node/version",
  :display_name => "The version of node to install",
  :default => "HEAD"

