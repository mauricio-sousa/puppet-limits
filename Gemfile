source :rubygems
gem 'rake'
gem 'puppet-lint'
gem 'rspec'
gem 'rspec-puppet'

puppetversion = ENV.key?('PUPPET_VERSION') ? "~> #{ENV['PUPPET_VERSION']}" : ['>= 2.7']
gem 'puppet', puppetversion
gem 'puppetlabs_spec_helper'

if RUBY_VERSION < '2.0.0'
  gem 'json', '< 2'
  gem 'json_pure', '< 2'
  gem 'metadata-json-lint', '< 1.2.0'
else
  gem 'metadata-json-lint'
end