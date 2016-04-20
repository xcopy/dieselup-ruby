# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dieselup/version'

Gem::Specification.new do |spec|
  spec.name          = 'dieselup'
  spec.version       = Dieselup::VERSION
  spec.author        = 'Kairat Jenishev'
  spec.email         = 'kairat.jenishev@gmail.com'

  spec.summary       = 'DieselUp!'
  spec.description   = 'Lift up your topic to the top in Diesel Forum'
  spec.homepage      = 'https://github.com/xcopy/dieselup-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($\)
  spec.bindir        = 'bin'
  spec.executables   = ['dieselup']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'activesupport', '~> 4.2'
end
