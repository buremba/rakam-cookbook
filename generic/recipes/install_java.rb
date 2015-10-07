#
# Cookbook Name:: java8
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'java::oracle'
include_recipe 'maven'

user 'webapp' do
  comment 'Operation user'
  home '/home/webapp'
end
