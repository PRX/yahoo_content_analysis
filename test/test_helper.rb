# -*- encoding: utf-8 -*-

# ENV['EXCON_DEBUG'] = 'true'

require 'simplecov'
SimpleCov.start

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest'
require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'
require 'webmock/minitest'
require 'hashie/mash'

require 'yahoo_content_analysis'

YahooContentAnalysis.configure do |y|
  y.api_key = ENV['YAHOO_API_KEY'] || 'test_api_key'
  y.api_secret = ENV['YAHOO_API_SECRET'] || 'test_api_secret'
end