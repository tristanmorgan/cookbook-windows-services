#
# Cookbook Name:: windows-services
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'windows-services::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'disables un-needed services' do
      expect(chef_run).to disable_service('Themes')
      expect(chef_run).to disable_service('Spooler')
    end
  end
end
