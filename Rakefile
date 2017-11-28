require 'rubocop/rake_task'
require 'foodcritic'
require 'rspec/core/rake_task'
require 'kitchen/rake_tasks'

RuboCop::RakeTask.new do |rubocop|
  rubocop.options = ['-D']
end

FoodCritic::Rake::LintTask.new do |foodcritic|
  foodcritic.options[:fail_tags] = ['any']
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/unit/**/*_spec.rb'
end

FoodCritic::Rake::LintTask.new

desc 'Run Rubocop and Foodcritic style checks'
task style: ['berks:clean', :rubocop, :foodcritic, 'berks:vendor', 'packer:validate']

desc 'Run all style checks and unit tests'
task test: %i[style spec]

task default: :test

namespace :serverspec do
  targets = ['localhost']

  task all: targets
  task default: :all

  targets.each do |target|
    original_target = target == '_default' ? target[1..-1] : target
    desc "Run serverspec tests to #{original_target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = original_target
      t.pattern = "spec/#{original_target}/*_spec.rb"
    end
  end
end

Kitchen::RakeTasks.new

namespace :packer do
  desc 'run packer validate'
  task :validate do
    puts 'Running Packer Validate'
    require 'mixlib/shellout'
    cmd = Mixlib::ShellOut.new(
      'packer validate'\
  ' -var-file=runtime-vars.json'\
  ' packer-aws.json'
    )
    cmd.live_stdout = $stdout
    cmd.live_stderr = $stderr
    cmd.run_command
    cmd.error!
  end

  desc 'run packer build'
  task :build do
    puts 'Running Packer Build'
    require 'mixlib/shellout'
    cmd = Mixlib::ShellOut.new(
      'packer build'\
      ' -var-file=runtime-vars.json'\
      ' packer-aws.json'
    )
    cmd.live_stdout = $stdout
    cmd.live_stderr = $stderr
    cmd.run_command
    cmd.error!
  end
end

namespace :berks do
  desc 'Run berks vendor'
  task :vendor do
    require 'berkshelf'
    puts 'berks vendor to vendor/cookbooks'
    Berkshelf.ui.mute do
      berksfile = Berkshelf::Berksfile.from_file('Berksfile')
      berksfile.vendor('vendor/cookbooks')
    end
  end

  desc 'Clean vendor folder'
  task :clean do
    puts 'berks clean-up'
    FileUtils.rm_rf('vendor/cookbooks') if File.exist?('vendor/cookbooks')
  end
end
