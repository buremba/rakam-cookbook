#
# Cookbook Name:: java8
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'java::oracle'


bash "create application user" do
  code <<-EOH
    adduser --system --shell /bin/bash --group --disabled-password --home /home/webapp webapp
  EOH
end
