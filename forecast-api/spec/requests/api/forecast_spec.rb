require 'rails_helper'

RSpec.describe "Forecast API", type: :request do
  let(:zip) { '110001' }
  let(:geo) { { lat: 12.34, lon: 56.78, address: 'Some Address' } }
  let(:temperature) { 25.678 }

  before do
    # Limpa o cache antes de cada teste
    Rails.cache.clear

    # Mocka os serviços externos
    allow(GeocodingService).to receive(:extract_zip_and_coords).and_return(geo)
    allow(WeatherService).to receive(:fetch_by_coords)
      .and_return({ 'data_current' => { 'temperature' => temperature } })
  end

  context 'when zip is invalid' do
    before do
      allow(GeocodingService).to receive(:extract_zip_and_coords)
        .with('00000').and_return({ lat: nil, lon: nil })
    end

    it 'returns status 400 and error message' do
      post "/api/forecast", params: { zip: '00000' }

      expect(response).to have_http_status(:bad_request)
      json = JSON.parse(response.body)
      expect(json['error']).to be true
      expect(json['message']).to eq('Invalid or not found ZIP Code')
    end
  end

  context 'when zip is valid' do
    it 'returns temperature, address and cached false on first request, cached true on second request' do
      allow(Rails.cache).to receive(:exist?).and_return(false)
      allow(Rails.cache).to receive(:fetch).and_call_original

      post "/api/forecast", params: { zip: zip }
      first_json = JSON.parse(response.body)

      expect(first_json['currentTemperature']).to eq(temperature.round(1))
      expect(first_json['address']).to eq(geo[:address])
      expect(first_json['cached']).to be false

      allow(Rails.cache).to receive(:exist?).and_return(true)

      post "/api/forecast", params: { zip: zip }
      second_json = JSON.parse(response.body)

      expect(second_json['currentTemperature']).to eq(temperature.round(1))
      expect(second_json['cached']).to be true
      expect(second_json['address']).to eq(geo[:address])
    end
  end
end
