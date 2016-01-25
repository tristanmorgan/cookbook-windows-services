require 'rubocop/rake_task'
# require 'foodcritic'
require 'rspec/core/rake_task'

RuboCop::RakeTask.new do |rubocop|
  rubocop.options = ['-D']
end

# FoodCritic::Rake::LintTask.new do |foodcritic|
#  foodcritic.options[:fail_tags] = 'any'
# end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

desc 'Run Rubocop and Foodcritic style checks'
task style: [:rubocop] # , :foodcritic]

desc 'Run all style checks and unit tests'
task test: [:style, :spec]

task default: :test
