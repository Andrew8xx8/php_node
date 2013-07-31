#
# Cookbook Name:: php_node
# Recipe:: default
#
# Copyright 2013, Andrew Kulakov <avk@8xx8.ru>
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
