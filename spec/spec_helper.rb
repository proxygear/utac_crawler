require 'rubygems'
require 'bundler/setup'

require 'httparty'
require 'nokogiri'
require 'utac'
require 'utac/client'
require 'utac/center'
require 'utac/configuration'

#require 'rspec'
require "rspec/expectations"

RSpec.configuration.expect_with :stdlib

RSpec.configure do |config|
  
  
  config.mock_with :rspec
end