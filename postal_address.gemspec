# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'postal_address/version'

Gem::Specification.new do |spec|
  spec.name          = "postal_address"
  spec.version       = Postal::VERSION
  spec.authors       = ["Kevin Melchert"]
  spec.email         = ["kevin.melchert@gmail.com"]
  spec.description   = %q{International postal address formatting}
  spec.summary       = %q{International postal address formatting}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", '~> 4.7.0'
  spec.add_development_dependency "turn"
  spec.add_development_dependency "virtus"
end
