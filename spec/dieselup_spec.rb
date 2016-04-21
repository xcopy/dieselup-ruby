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
    it 'should send GET request and get successful response' do
      response = @base.request(Dieselup::Url::BASE)

      expect(response.code).to eq '200'
      expect(response.content_type).to eq 'text/html'
    end

    it 'should send GET request and get response with error message' do
      response = @base.request(Dieselup::Url.get(showtopic: 1234567890))
      document = Nokogiri::HTML(response.body)
      errors = document.css('div.errorwrap')

      expect(errors).not_to be_empty
      expect(errors.first).to be_instance_of Nokogiri::XML::Element
    end


    it 'should send POST request and get successful response' do
      response = @base.login
      document = Nokogiri::HTML(response.body)

      expect(response.code).to eq '200'
      expect(document.at("p:contains(#{ENV['USERNAME']})")).to_not be_nil
    end
  end
end
