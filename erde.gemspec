# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'erde/version'

Gem::Specification.new do |spec|
  spec.name          = "erde"
  spec.version       = Erde::VERSION
  spec.authors       = ["David Strauß"]
  spec.email         = ["david@strauss.io"]

  spec.summary       = %q{Entity-Relationship-Diagramm-Erzeuger}
  spec.description   = %q{Generate good looking Entity-Relationship-Diagrams from text files or a PostgreSQL database.}
  spec.homepage      = "https://github.com/edgycircle/erde"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = "erde"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "sequel", "~> 4.0"
end
