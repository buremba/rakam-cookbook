#
# Cookbook Name:: java8
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'java::oracle'
include_recipe 'ark::default'

ark 'maven' do
  url             'http://apache.mirrors.tds.net/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz'
  checksum        '8c190264bdf591ff9f1268dc0ad940a2726f9e958e367716a09b8aaa7e74a755'
  home_dir        '/usr/local/maven'
  win_install_dir '/usr/local/maven'
  version         '3.2.5'
  append_env_path true
end

bash "create application user" do
  code <<-EOH
    adduser --system --shell /bin/bash --group --disabled-password --home /home/webapp webapp
  EOH
end
