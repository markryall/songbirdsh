Gem::Specification.new do |spec|
  spec.name = 'songbirdsh'
  spec.version = '0.0.1'
  spec.summary = 'command line jukebox music player'
  spec.description = <<-EOF
A command line jukebox music player that uses your songbird music player database
EOF
  spec.authors << 'Mark Ryall'
  spec.email = 'mark@ryall.name'
  spec.homepage = 'http://github.com/markryall/songbirdsh'
  spec.files = Dir['lib/**/*'] + Dir['bin/*'] + ['README.rdoc', 'MIT-LICENSE', 'gemspec']
  spec.executables << 'songbirdsh'

  spec.add_dependency 'splat', '~>0.1'
  spec.add_dependency 'shell_shock', '~>0.0.5'
  spec.add_dependency 'sequel', '~> 3'
  spec.add_dependency 'splat', '~> 0.1'
  spec.add_dependency 'sqlite3', '~> 1'

  spec.add_development_dependency 'rake', '~>0.8.7'
  spec.add_development_dependency 'gemesis', '~>0.0.4'
end