ENV['RACK_ENV'] = 'test'

require 'hukku'
require 'rspec'
require 'rack/test'

describe 'The Hukku App' do
  include Rack::Test::Methods

  def app
    Hukku::App
  end

  def payload
    File.read(File.join(File.dirname(__FILE__),"sample_payload.json"))
  end

  it "error empty payload" do
    post '/sfjp'
    expect(last_response).not_to be_ok
  end

  it "ok when 'payload' has json" do
    post '/sfjp', "payload" => payload
    expect(last_response).to be_ok
  end

  it "validate json" do
    post '/sfjp', "payload" => '{"invalid":"content"}'
    expect(last_response).not_to be_ok
  end
end
