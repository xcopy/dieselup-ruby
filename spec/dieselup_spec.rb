require 'spec_helper'

describe Dieselup do
  it 'has a version number' do
    expect(Dieselup::VERSION).not_to be nil
  end

  it 'has correct URLs' do
    expect(Dieselup::Url::BASE).to eq 'https://diesel.elcat.kg/index.php'
    expect(Dieselup::Url.get({showtopic: 1})).to eq 'https://diesel.elcat.kg/index.php?showtopic=1'
  end

  it 'should send request' do
    url = URI.parse(Dieselup::Url::BASE)
    http = Net::HTTP.new(url.host, url.port)

    if url.scheme == 'https'
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    request = Net::HTTP::Get.new(url.to_s)
    response = http.request(request)

    expect(response.code).to eq '200'
    expect(response.content_type).to eq 'text/html'
  end
end
