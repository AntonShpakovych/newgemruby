# frozen_string_literal: true

require_relative 'lib/codebreaker/version'

Gem::Specification.new do |spec|
  spec.name = 'codebreaker'
  spec.version = Codebreaker::VERSION
  spec.authors = ['AntonShpakovych']
  spec.email = ['shpakovych18@gmail.com']
  spec.summary = 'Codebreaker is a logic game in which a
                  code-breaker tries to break a secret code created by a code-maker.'
  spec.description = "Codebreaker is a logic game in which a code-breaker tries to break a secret code
                      created by a code-maker.
                      The codemaker, which will be played by the application we're going to write,
                      creates a secret code of four numbers between 1 and 6.
                      The codebreaker gets some number of chances to break the code (depends on chosen difficulty).
                      In each turn, the codebreaker makes a guess of 4 numbers."
  spec.homepage =  'https://github.com/AntonShpakovych/newgemruby'
  spec.license = 'MIT'
  spec.required_ruby_version = '~> 2.7.3'
  spec.metadata['allowed_push_host'] = 'https://github.com/AntonShpakovych/newgemruby'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/CHANGELOG.md"
  spec.files = Dir['{circleci,lib,spec/factories,spec/fixtures}/**/*', '*.md']
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_dependency 'bundler', '~> 2.3.7'
  spec.add_dependency 'rake', '~> 13.0.6'
  spec.add_development_dependency 'fasterer', '~> 0.10.0'
  spec.add_development_dependency 'i18n', '~> 1.10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.30.1'
  spec.add_development_dependency 'rubocop-performance', '~> 1.14.2'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.11.1'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
  spec.add_runtime_dependency 'yaml', '~> 0.2.0'
  spec.metadata['rubygems_mfa_required'] = 'true'
end