module Dieselup
  class Base
    def self.up!
      login
      post
    end

    def self.login
    end

    def self.post
    end

    private

    def self.request(url, method = Net::HTTP::Get::METHOD, body = nil)
      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.to_s)
      response = http.request(request)

      response
    end
  end
end