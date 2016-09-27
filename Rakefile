require 'rubocop/rake_task'
require 'foodcritic'
require 'rspec/core/rake_task'
require 'kitchen/rake_tasks'

RuboCop::RakeTask.new do |rubocop|
  rubocop.options = ['-D']
end

FoodCritic::Rake::LintTask.new do |foodcritic|
  foodcritic.options[:fail_tags] = 'any'
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/unit/**/*_spec.rb'
end

FoodCritic::Rake::LintTask.new

desc 'Run Rubocop and Foodcritic style checks'
task style: [:rubocop, :foodcritic]

desc 'Run all style checks and unit tests'
task test: [:style, :spec]

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
  desc 'run packer build'
  task :build do
    require 'mixlib/shellout'
    cmd = Mixlib::ShellOut.new('packer validate packer-aws.json')
    cmd.live_stdout = $stdout
    cmd.run_command
    cmd.error!
  end
end
