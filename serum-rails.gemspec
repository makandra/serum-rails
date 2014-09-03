$:.push File.expand_path("../lib", __FILE__)
require "serum/rails/version"

Gem::Specification.new do |s|
  s.name = 'serum-rails'
  s.version = Serum::Rails::VERSION
  s.authors = ["Henning Koch"]
  s.email = 'henning.koch@makandra.de'
  s.homepage = 'https://github.com/makandra/serum-rails'
  s.summary = 'Scans a Rails application for metrics relevant to security audits'
  s.description = s.summary
  s.license = 'MIT'

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_development_dependency "rake"
  s.add_runtime_dependency('activesupport', '>= 3.2')

end
