class WeatherService
  include HTTParty
  base_uri 'https://my.meteoblue.com/packages'

  def self.fetch_by_coords(lat:, lon:)
    res = get('/current', query: {lat: lat, lon: lon, apikey: ENV.fetch('METEOBLUE_API_KEY')})
    unless res.success?
      raise "Weather API error: #{res.code} - #{res.body}"
    end

    res.parsed_response
  end
end