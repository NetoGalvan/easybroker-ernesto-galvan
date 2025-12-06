require 'minitest/autorun'
require 'webmock/minitest'
require_relative '../lib/services/properties_service'

WebMock.disable_net_connect!(allow_localhost: true)
