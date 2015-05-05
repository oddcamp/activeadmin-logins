# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_admin/logins/version'

Gem::Specification.new do |spec|
  spec.name          = "activeadmin-logins"
  spec.version       = ActiveAdmin::Logins::VERSION
  spec.authors       = ["Ivan Novosad"]
  spec.email         = ["ivan.novosad@gmail.com"]
  spec.summary       = %q{Write a short summary. Required.}
  spec.description   = %q{Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib", "app", "data"]

  spec.add_runtime_dependency 'rails', '>= 4.1.0'
  spec.add_runtime_dependency "sidekiq", ">= 3.0.0"
  spec.add_runtime_dependency "devise", ">= 3.2.4"
  spec.add_runtime_dependency "geoip", "~> 1.5.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
