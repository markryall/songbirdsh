Gem::Specification.new do |spec|
  spec.name = 'songbirdsh'
  spec.version = '0.0.5'
  spec.summary = 'command line jukebox music player'
  spec.description = <<-EOF
A command line jukebox music player that uses your songbird music player database
EOF
  spec.authors << 'Mark Ryall'
  spec.email = 'mark@ryall.name'
  spec.homepage = 'http://github.com/markryall/songbirdsh'
  spec.files = Dir['lib/**/*'] + Dir['spec/**/*'] + Dir['bin/*'] + ['README.rdoc', 'HISTORY.rdoc','MIT-LICENSE', '.gemtest', 'Rakefile']
  spec.executables << 'songbirdsh'

  spec.add_dependency 'splat', '~>0'
  spec.add_dependency 'shell_shock', '~>0'
  spec.add_dependency 'sequel', '~> 3'
  spec.add_dependency 'sqlite3', '~> 1'
  spec.add_dependency 'simple_scrobbler', '~> 0'
  spec.add_dependency 'rainbow', '~> 1'

  spec.add_development_dependency 'rake', '~>0.8'
  spec.add_development_dependency 'rspec', '~>2'
end
