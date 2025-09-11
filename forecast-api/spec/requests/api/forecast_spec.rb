require 'rails_helper'
require 'webmock/rspec'
require 'ostruct'

RSpec.describe "Forecast API", type: :request do
  let(:zip) { '110001' }
  let(:geo) { { lat: '12.34', lon: '56.78', address: 'Some Address' } }
  let(:temperature) { 25.6 }
  let(:isdaylight) { true }
  let(:time) { '2025-09-11T10:00:00Z' }

  # Cache control
  before { ActionController::Base.perform_caching = true }
  after  { ActionController::Base.perform_caching = false }

  before do
    # Clears the cache before each test and sets the env
    Rails.cache.clear
    ENV['METEOBLUE_API_KEY'] = 'fake_api_key'

    # Geocoder stub to avoid relying on external calls
    allow(Geocoder).to receive(:search).with(zip).and_return([
      OpenStruct.new(latitude: geo[:lat], longitude: geo[:lon], postal_code: geo[:zip], address: geo[:address])
    ])
    
    stub_request(:get, "https://my.meteoblue.com/packages/current")
      .with(query: hash_including({ lat: geo[:lat], lon: geo[:lon], apikey: ENV['METEOBLUE_API_KEY']}))
      .to_return(
        status: 200,
        body: {
          data_current: {
            temperature: temperature,
            isdaylight: isdaylight,
            time: time
          }
        }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end

  context 'when zip is invalid' do
    before do
      allow(Geocoder).to receive(:search).with('00000').and_return([])
    end

    it 'returns status 422 and error message' do
      post "/api/forecast", params: { zip: '00000' }

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['error']).to eq("Could not find ZIP code")
    end
  end

  context 'when zip is valid' do
    it 'returns forecast and cache flag correctly' do

      # First request → does not come from the cache
      post "/api/forecast", params: { zip: zip }
      first_json = JSON.parse(response.body)
      
      expect(first_json['currentTemperature']).to eq(temperature)
      expect(first_json['isDay']).to eq(isdaylight)
      expect(first_json['localTime']).to eq(time)
      expect(first_json['cached']).to be false
      expect(first_json['address']).to eq(geo[:address])

      # Second request → should come from the cache
      post "/api/forecast", params: { zip: zip }
      second_json = JSON.parse(response.body)

      expect(second_json['currentTemperature']).to eq(temperature)
      expect(second_json['cached']).to be true
      expect(second_json['address']).to eq(geo[:address])
    end
  end
end
