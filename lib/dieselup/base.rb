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
        url = Dieselup::Url.get({act: 'Login', CODE: '01'})
        params = {UserName: ENV['USERNAME'], PassWord: ENV['PASSWORD']}
        request(url, 'POST', params)
      end
    end

    def post
    end

    def request(url, method = 'GET', params = {})
      uri = URI.parse(url)

      if method.upcase == 'POST'
        Net::HTTP.post_form(uri, params)
      else
        Net::HTTP.get_response(uri)
      end
    end
  end
end