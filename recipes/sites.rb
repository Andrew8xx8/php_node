#
# Cookbook Name:: php_node
# Recipe:: default
#
# Copyright 2013, Andrew Kulakov <avk@8xx8.ru>
#
# All rights reserved - Do Not Redistribute
#

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}

node[:sites].each do |site|
  sites_path = "/u/apps"
  site_path = "#{sites_path}/#{site[:name]}"
  public_path = "#{site_path}/public"
  private_path = "#{site_path}/private"
  log_path = "#{site_path}/log"
  domain = site[:domain]

  directory private_path do
    recursive true
    owner 'www-data'
    group 'www-data'
    mode "0755"
  end

  directory public_path do
    recursive true
    owner 'www-data'
    group 'www-data'
    mode "0755"
  end

  directory log_path do
    recursive true
    owner 'www-data'
    group 'www-data'
    mode "0755"
  end

  template "/etc/nginx/conf.d/#{site[:name]}.conf" do
    source "nginx_site.conf.erb"
    variables domain: domain, public_path: public_path, log_path: log_path, document_root: site[:name]
    notifies :restart, resources(:service => "nginx")
  end

  mysql_database "#{site[:name]}_main" do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user site[:name] do
    connection mysql_connection_info
    password site[:mysql_password]
    action :create
  end

  mysql_database_user site[:name] do
    connection mysql_connection_info
    password site[:mysql_password]
    action :grant
  end
end
