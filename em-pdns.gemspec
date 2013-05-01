# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pdns/version'

Gem::Specification.new do |spec|
  spec.name          = "em-pdns"
  spec.version       = PDNS::VERSION
  spec.authors       = ["Keith Larrimore"]
  spec.email         = ["klarrimore@icehook.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = "https://github.com/federate/em-pdns"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rspec', '~> 2.13.0'
  spec.add_development_dependency 'rake'  
  spec.add_runtime_dependency 'sinatra', '~> 1.4.2'
  spec.add_runtime_dependency 'thin', '~> 1.5.1'
  spec.add_runtime_dependency 'yajl-ruby', '~> 1.1.0'
  spec.add_runtime_dependency 'multi_json',  '~> 1.7.2'
end
