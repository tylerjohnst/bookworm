require "bundler/gem_tasks"

task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.pattern = FileList['test/**/*_test.rb']
  test.verbose = true
end