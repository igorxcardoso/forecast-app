class WeatherService
  include HTTParty
  
  class WeatherAPIError < StandardError; end

  base_uri 'https://my.meteoblue.com/packages'
  CACHE_TTL = 30.minutes

  def self.fetch_by_coords(lat:, lon:, zip:)
    cache_key = "forecast:#{zip}"
    cached = Rails.cache.exist?(cache_key)

    data = Rails.cache.fetch(cache_key, expires_in: CACHE_TTL) do
      response = get('/current', query: {lat: lat, lon: lon, apikey: ENV.fetch('METEOBLUE_API_KEY')})
      raise WeatherAPIError , "Weather API error. Please try again!" unless response.success?
      data_current = response.parsed_response.dig('data_current')
      {
        temperature: data_current.dig('temperature'), 
        isdaylight: data_current.dig('isdaylight'),
        time: data_current.dig('time')
      }
    end
    
    Rails.logger.info("Cache hit for #{cache_key}: #{cached}")

    { data: data, cached: cached }
  end
end