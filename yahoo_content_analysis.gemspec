# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yahoo_content_analysis/version'

Gem::Specification.new do |gem|
  gem.name          = "yahoo_content_analysis"
  gem.version       = YahooContentAnalysis::VERSION
  gem.authors       = ["Andrew Kuklewicz"]
  gem.email         = ["andrew@prx.org"]
  gem.description   = %q{Use the Yahoo! Content Analysis API to extract topics and entities.}
  gem.summary       = %q{Use the Yahoo! Content Analysis API to extract topics and entities.}
  gem.homepage      = "https://github.com/PRX/yahoo_content_analysis"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency('faraday', ['>= 0.7.4', '< 0.9'])
  gem.add_runtime_dependency('faraday_middleware', '~> 0.9')
  gem.add_runtime_dependency('multi_json', '>= 1.0.3', '~> 1.0')
  gem.add_runtime_dependency('excon')
  gem.add_runtime_dependency('hashie',  '>= 0.4.0')
  gem.add_runtime_dependency('simple_oauth')
  gem.add_runtime_dependency('language_list')

  gem.add_development_dependency('rake')
  gem.add_development_dependency('minitest')
end
