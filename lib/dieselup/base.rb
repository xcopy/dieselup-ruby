module Dieselup
  class Base
    attr_accessor :cookies

    def initialize
      @cookies = []
    end

    def up!
      begin
        login
        post
      rescue => e
        log(e.message, nil, :red)
      end
    end

    def login
      log('Checking access', :yellow)

      response = request(Dieselup::Url::BASE)
      document = Nokogiri::HTML(response.body)

      if document.css('div#userlinks').empty?
        log('Logging in', :yellow)

        url = Dieselup::Url.get(act: 'Login', CODE: '01')
        params = {UserName: ENV['USERNAME'], PassWord: ENV['PASSWORD']}
        response = request(url, 'POST', params)
      end

      log('Logged in', :green)

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
        log('Deleting last UP', :yellow)

        request(delete_links.last)
      end

      params = {Post: 'UP'}

      hidden_inputs = document.css('//form[@name*="REPLIER"]/input[@type*="hidden"]')
      hidden_inputs.each do |input|
        params[input[:name]] = input[:value]
      end

      log('Posting new UP', :green)

      request(Dieselup::Url::BASE, 'POST', params)
    end

    def request(url, method = 'GET', params = {})
      puts Rainbow("#{method} #{url}").color(:silver).bright

      uri = URI(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      http.verify_mode = 0

      if method.upcase == 'POST'
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data(params)
      else
        request = Net::HTTP::Get.new(uri.request_uri)
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

    def log(message, *colors)
      color, background, bright = colors

      rainbow = Rainbow(message.to_s).color(color.try(:to_sym) || :white)

      if background
        rainbow = rainbow.background(background.to_sym)
      end

      puts rainbow
    end
  end
end