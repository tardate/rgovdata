# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'rspec'
require 'rspec/core/rake_task'

$LOAD_PATH.unshift('lib')
require 'rgovdata/version'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "rgovdata"
  gem.version = RGovData::Version::STRING
  gem.homepage = "http://github.com/tardate/rgovdata"
  gem.license = "MIT"
  gem.summary = %Q{Really simple access to government data for ruby}
  gem.description = %Q{Consuming government-published data in a ruby or rails application shouldn't require a PhD}
  gem.email = "gallagher.paul@gmail.com"
  gem.authors = ["Paul Gallagher"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

desc "Run only RSpec unit test examples"
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["-c", "-f progress"]
  t.pattern = 'spec/unit/**/*_spec.rb'
end

desc "Run only RSpec integration test examples"
RSpec::Core::RakeTask.new(:'spec:integration') do |t|
  t.rspec_opts = ["-c", "-f progress"]
  t.pattern = 'spec/integration/**/*_spec.rb'
end

desc "Run all RSpec test examples"
RSpec::Core::RakeTask.new(:'spec:all') do |t|
  t.rspec_opts = ["-c", "-f progress"]
  t.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

require 'rdoc/task'
RDoc::Task.new do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rgovdata #{RGovData::Version::STRING}"
  rdoc.rdoc_files.include("README.rdoc", "lib/**/*.rb")
end

