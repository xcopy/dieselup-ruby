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

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'dotenv', '~> 2.1'
  spec.add_development_dependency 'rspec', '~> 3.4'

  spec.add_runtime_dependency 'activesupport', '~> 4.2'
  spec.add_runtime_dependency 'nokogiri', '1.6'
  spec.add_runtime_dependency 'rainbow', '~> 2.1'
end
