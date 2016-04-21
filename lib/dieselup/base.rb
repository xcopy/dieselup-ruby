require 'nokogiri'

module Dieselup
  class Base
    def self.up!
      login
      post
    end

    def self.login
      response = request(Dieselup::Url::BASE)
      document = Nokogiri::HTML(response.body)

      if document.css('div#userlinks').empty?
        url = Dieselup::Url.get({act: 'Login', CODE: '01'})
        params = {UserName: ENV['USERNAME'], PassWord: ENV['PASSWORD']}
        request(url, 'POST', params)
      end
    end

    def self.post
    end

    def self.request(url, method = 'GET', params = {})
      uri = URI.parse(url)

      response = if method.upcase == 'POST'
        Net::HTTP.post_form(uri, params)
      else
        Net::HTTP.get_response(uri)
      end

      response
    end
  end
end