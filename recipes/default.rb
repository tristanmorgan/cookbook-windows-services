#
# Cookbook Name:: windows-services
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

service 'Themes' do
  action %i[disable stop]
end

service 'Spooler' do
  action %i[disable stop]
end
