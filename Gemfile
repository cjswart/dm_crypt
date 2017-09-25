source ENV['GEM_SOURCE'] || "https://rubygems.org"

# An update in rake 11.0.0 breaks stuff.
# Removed Rake::TaskManager#last_comment. Use last_description.
# RSPEC
group :test do
  gem 'diff-lcs', '~> 1.3'
  gem 'metaclass', '~> 0.0.4'
  gem 'metadata-json-lint', '~> 1.1.0'
  gem 'mocha', '~> 1.2.1'
  gem 'puppet', ENV['PUPPET_VERSION'] || '~> 4.8.1'
  gem 'puppet-lint', '~> 2.2.1'
  gem 'puppet-syntax', '~> 2.4.0'
  gem 'puppetlabs_spec_helper', '~> 2.1.1'
  gem 'rake', '~> 12.0.0'
  gem 'rspec', '~> 3.5.0'
  gem 'rspec-core', '~> 3.5.4'
  gem 'rspec-expectations', '~> 3.5.0'
  gem 'rspec-mocks', '~> 3.5.0'
  gem 'rspec-puppet', '~> 2.5.0'
  gem 'rspec-puppet-utils', '~> 3.1.0'
  gem 'rspec-support', '~> 3.5.0'
  gem 'spdx-licenses', '~> 1.1.0'
end

