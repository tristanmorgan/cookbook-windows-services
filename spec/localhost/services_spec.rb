require 'spec_helper'

describe port(3389), if: os[:family] == 'windows' do
  it { should be_listening }
end

describe service('Themes') do
  it { should_not be_running }
  it { should_not be_enabled }
  it { should have_start_mode('Disabled') }
end

describe user('vagrant') do
  it { should exist }
end
