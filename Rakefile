Gem::Specification.load('gemspec').dependencies.each { |dep| gem dep.name, dep.requirement }
require 'gemesis/rake'

desc 'execute specifications'
task :test do
  sh 'rspec spec'
end