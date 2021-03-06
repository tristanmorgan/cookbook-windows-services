require 'spec_helper'

describe 'windows-services::default' do
  describe port(3389), if: os[:family] == 'windows' do
    it { should be_listening }
  end

  describe service('Themes') do
    it { should_not be_running }
    it { should_not be_enabled }
    it { should have_start_mode('Disabled') }
  end
end
