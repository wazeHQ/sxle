# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sxle/version'

Gem::Specification.new do |spec|
  spec.name          = "sxle"
  spec.version       = Sxle::VERSION
  spec.authors       = ["David Elentok"]
  spec.email         = ["3david@gmail.com"]
  spec.description   = %q{General purpose utilities}
  spec.summary       = %q{General purpose utilities}
  spec.homepage      = "http://github.com/wazeHQ/sxle"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  #spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  #spec.add_dependency "rails",               ">= 3.2.0"
  spec.add_dependency "i18n"
  spec.add_dependency "haml_coffee_assets",  "~> 1.16.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "actionpack", ">= 3.1.0"
end
