module Dieselup
  class Base
    def initialize
      Dotenv.load('.env')
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
    end

    def request(url, method = 'GET', params = {})
      uri = URI(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      if method.upcase == 'POST'
        request = Net::HTTP::Post.new(uri)
        request.set_form_data(params)
      else
        request = Net::HTTP::Get.new(uri)
      end

      http.request(request)
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