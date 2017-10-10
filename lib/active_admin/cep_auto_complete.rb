require 'active_support/core_ext'
require 'active_admin'

module ActiveAdmin
  module CepAutoComplete
    DEFAULT_FIELDS = [:state, :city, :neighborhood, :street].freeze
    CEP_REGEX_BODY = '[0-9]{2}(\.)?[0-9]{3}(\-)?[0-9]{3}'.freeze

    autoload :Version,  'active_admin/cep_auto_complete/version'
    autoload :Page,     'active_admin/cep_auto_complete/page'
    autoload :DSL,      'active_admin/cep_auto_complete/dsl'
    autoload :Query,    'active_admin/cep_auto_complete/query'
    autoload :Renderer, 'active_admin/cep_auto_complete/renderer'
  end
end

require 'active_admin/cep_auto_complete/engine'
require 'formtastic/inputs/cep_input'

ActiveAdmin::Page.send(:include, ActiveAdmin::CepAutoComplete::Page)
ActiveAdmin::DSL.send(:include, ActiveAdmin::CepAutoComplete::DSL)
