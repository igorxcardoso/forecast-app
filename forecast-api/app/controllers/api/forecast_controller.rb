class Api::ForecastController < ApplicationController
  def create
    zip = params[:zip]&.to_s.strip
    geo = GeocodingService.extract_zip_and_coords(zip)
    forecast = WeatherService.fetch_by_coords(lat: geo[:lat], lon: geo[:lon], zip: zip)

    render json: { 
      currentTemperature: forecast[:data].dig(:temperature)&.round(1),
      isDay: forecast[:data].dig(:isdaylight),
      localTime: forecast[:data].dig(:time),
      cached: forecast[:cached],
      address: geo[:address]
    }, status: :ok

  rescue GeocodingService::AddressNotFound => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue WeatherService::WeatherAPIError => e
    render json: { error: e.message }, status: :bad_gateway
  rescue ArgumentError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
