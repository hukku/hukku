# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hukku/version'

Gem::Specification.new do |spec|
  spec.name          = "hukku"
  spec.version       = Hukku::VERSION
  spec.authors       = ["tohosaku"]
  spec.email         = ["ny@cosmichorror.org"]
  spec.description   = %q{receive web hook}
  spec.summary       = %q{receive web hook}
  spec.homepage      = ""
  spec.license       = "GPL3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "sinatra-contrib"
  spec.add_dependency "systemu"
  spec.add_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "thor"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
