# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'greeklish/version'

Gem::Specification.new do |spec|
  spec.name          = "greeklish"
  spec.version       = Greeklish::VERSION
  spec.authors       = ["Petros Markou"]
  spec.email         = ["markoupetr@skroutz.gr"]
  spec.summary       = %q{Generates greeklish forms}
  spec.description   = %q{Configurable generator of Greek words to greeklish forms.}
  spec.homepage      = "https://github.com/skroutz/greeklish"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.9"
end
