class Api::ForecastController < ApplicationController
  def create
    zip = params[:zip]
    geo = GeocodingService.extract_zip_and_coords(zip)
    
    if geo[:lat].nil? || geo[:lon].nil?
      render json: { error: true, message: '' }, status: :bad_request
    else
      cache_key = "forecast:#{zip}"
      cached = Rails.cache.exist?(cache_key)

      forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
        data = WeatherService.fetch_by_coords(lat: geo[:lat], lon: geo[:lon])
        data.dig('data_current', 'temperature')
      end

      Rails.logger.info("Cache hit for #{cache_key}: #{cached}")

      render json: { 
        currentTemperature: forecast,
        cached: cached
      }
    end
  end
end
