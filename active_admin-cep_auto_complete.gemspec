$:.push File.expand_path('../lib', __FILE__)

require './lib/active_admin/cep_auto_complete/version'

Gem::Specification.new do |spec|
  spec.name        = 'active_admin-cep_auto_complete'
  spec.version     = ActiveAdmin::CepAutoComplete::Version::STRING
  spec.authors     = ['Dhyego Fernando']
  spec.email       = ['dhyegofernando@gmail.com']

  spec.summary     = 'Auto complete your addresses fields with Brazilian CEP (zip code).'
  spec.description = spec.summary
  spec.homepage    = 'http://github.com/dhyegofernando/active_admin-cep_auto_complete'
  spec.license     = 'MIT'

  spec.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.add_dependency 'railties'
  spec.add_dependency 'activeadmin', '>= 1.0.0.pre1'
  spec.add_dependency 'postmon_ruby'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-utils'
  spec.add_development_dependency 'pry-meta'
end
