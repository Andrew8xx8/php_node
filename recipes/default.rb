#
# Cookbook Name:: php_node
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'imagemagick'
package 'htop'

directory "/u/apps" do
  recursive true
  owner 'www-data'
  group 'www-data'
  mode "0755"
end
