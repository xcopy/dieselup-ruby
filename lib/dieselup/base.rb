module Dieselup
  class Base
    attr_accessor :cookies

    def initialize
      @cookies = []
    end

    def up!
      login
      post
    end

    def login
      response = request(Dieselup::Url::BASE)
      document = Nokogiri::HTML(response.body)

      if document.css('div#userlinks').empty?
        url = Dieselup::Url.get(act: 'Login', CODE: '01')
        params = {UserName: ENV['USERNAME'], PassWord: ENV['PASSWORD']}
        response = request(url, 'POST', params)
      end

      response
    end

    def post
      raise ArgumentError, 'Not enough arguments' unless ARGV.any?

      response = request(Dieselup::Url.get(showtopic: ARGV.first))
      document = Nokogiri::HTML(response.body)

      delete_links = document.css('//a[@href*="javascript:delete_post"]').map { |link|
        link[:href].match(/'([^']+)/).to_a.last
      }

      if delete_links.any?
        request(delete_links.last)
      end

      params = {Post: 'UP'}

      hidden_inputs = document.css('//form[@name*="REPLIER"]/input[@type*="hidden"]')
      hidden_inputs.each do |input|
        params[input[:name]] = input[:value]
      end

      request(Dieselup::Url::BASE, 'POST', params)
    end

    def request(url, method = 'GET', params = {})
      uri = URI(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      if method.upcase == 'POST'
        request = Net::HTTP::Post.new(uri)
        request.set_form_data(params)
      else
        request = Net::HTTP::Get.new(uri)
      end

      unless @cookies.empty?
        request['Cookie'] = @cookies.join(';')
      end

      response = http.request(request)

      document = Nokogiri::HTML(response.body)

      errors = document.xpath('//div[@class="errorwrap"]/p')

      raise StandardError, errors.first.text if errors.any?

      cookies = response.get_fields('set-cookie')
      cookies.each do |cookie|
        @cookies.push(cookie.split('; ').first)
      end

      response
    end

=begin
    def request(url, method = 'GET', params = {})
      uri = URI.parse(url)

      if method.upcase == 'POST'
        Net::HTTP.post_form(uri, params)
      else
        Net::HTTP.get_response(uri)
      end
    end
=end
  end
end