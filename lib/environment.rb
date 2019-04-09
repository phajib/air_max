require 'pry'
require 'nokogiri'
require 'open-uri'
require 'colorize'

require_relative './air_max/version'
require_relative './air_max/cli.rb'
require_relative './air_max/scraper.rb'
require_relative './air_max/air.rb'

module AirMax
  class Error < StandardError; end
  # Your code goes here...
end
