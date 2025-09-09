class Api::ForecastController < ApplicationController
  def create
    zip = params[:zip]
    geo = GeocodingService.extract_zip_and_coords(zip)
    forecast = WeatherService.fetch_by_coords(lat: geo[:lat], lon: geo[:lon])
    
    render json: { currentTemperature: forecast.dig('data_current', 'temperature') }
  end
end
