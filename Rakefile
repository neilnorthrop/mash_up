require 'rubygems'
require 'rake/testtask'
require 'rspec/core/rake_task'

Rake::TestTask.new do |task|
  task.libs << 'test'
end

desc 'Run tests'
task :default => :test

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['-f progress']
end

Rake::TestTask.new do |t|
  t.libs.push 'lib'
  t.test_files = FileList['spec/*_test.rb']
  t.verbose = true
end
