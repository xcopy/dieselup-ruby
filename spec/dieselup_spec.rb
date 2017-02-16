require 'spec_helper'

describe Dieselup do
  before(:all) do
    @base = Dieselup::Base.new
  end

  it 'has a version number' do
    expect(Dieselup::VERSION).not_to be_nil
  end

  it 'has environment .env file' do
    expect(File.exist?('.env')).to be_truthy
    expect(ENV['USERNAME']).to_not be_nil
    expect(ENV['PASSWORD']).to_not be_nil
  end

  context Dieselup::Url do
    it 'returns correct URLs' do
      expect(Dieselup::Url::BASE).to eq 'https://diesel.elcat.kg/index.php'
      expect(Dieselup::Url.get(showtopic: 1)).to eq 'https://diesel.elcat.kg/index.php?showtopic=1'
    end
  end

  context Dieselup::Base do
    it 'should have empty cookies' do
      expect(@base.cookies).to be_empty
    end

    it 'should login successfully' do
      response = @base.login
      document = Nokogiri::HTML(response.body)
      expect(document.at("a:contains(#{ENV['USERNAME']})")).to_not be_nil
    end

    it 'should send GET request and get HTTP response with status 200 OK' do
      response = @base.request(Dieselup::Url::BASE)
      expect(response.code).to eq '200'
    end

    it 'should send GET request and get HTTP response with status 404 Not Found' do
      response = @base.request(Dieselup::Url.get(showtopic: 1))
      expect(response.code).to eq '404'
    end
  end
end
