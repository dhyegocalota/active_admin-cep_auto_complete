$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'bundler/setup'
require 'active_admin/cep_auto_complete'
require 'minitest/autorun'
require 'minitest/utils'

FileList['./test/support/**/*.rb'].each { |file| require file }
