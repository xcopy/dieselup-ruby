require 'uri'
require 'net/http'
require 'active_support/core_ext/object/to_param'
require 'active_support/core_ext/object/try'
require 'nokogiri'
require 'dotenv'
require 'rainbow'

module Dieselup
  autoload :Base, 'dieselup/base'
  autoload :Url,  'dieselup/url'
end
