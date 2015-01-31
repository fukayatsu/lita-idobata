# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lita/idobata/version'

Gem::Specification.new do |spec|
  spec.name          = "lita-idobata"
  spec.version       = Lita::Idobata::VERSION
  spec.authors       = ["fukayatsu"]
  spec.email         = ["fukayatsu@gmail.com"]
  spec.summary       = %q{A Idobata adapter for Lita.}
  spec.description   = %q{A Idobata adapter for the Lita chat robot.}
  spec.homepage      = "https://github.com/fukayatsu/lita-idobata"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "adapter" }

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.0"
  spec.add_runtime_dependency 'faraday', '~> 0.9.0'
  spec.add_runtime_dependency 'pusher-client', '~> 0.6.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.1.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
