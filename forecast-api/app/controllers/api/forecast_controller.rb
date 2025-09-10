class Api::ForecastController < ApplicationController
  def create
    zip = params[:zip]&.strip
    geo = GeocodingService.extract_zip_and_coords(zip)
    
    if geo[:lat].nil? || geo[:lon].nil?
      render json: { error: true, message: 'Invalid or not found ZIP Code' }, status: :bad_request
    else
      cache_key = "forecast:#{zip}"
      cached = Rails.cache.exist?(cache_key)

      forecast = Rails.cache.fetch(cache_key, expires_in: 30.minutes) do
        WeatherService.fetch_by_coords(lat: geo[:lat], lon: geo[:lon])
      end

      Rails.logger.info("Cache hit for #{cache_key}: #{cached}")

      render json: { 
        currentTemperature: forecast.dig('data_current', 'temperature')&.round(1),
        isDay: forecast.dig('data_current', 'isdaylight'),
        localTime: forecast.dig('data_current', 'time'),
        cached: cached,
        address: geo[:address]
      }
    end
  end
end
