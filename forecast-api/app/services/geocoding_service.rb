class GeocodingService
  def self.extract_zip_and_coords(postal)
    raise ArgumentError, 'postal code blank' if postal.to_s.strip.empty?

    result = Geocoder.search(postal).first

    if result
      postcode = (result.data.dig('address', 'postcode') if result.data) || (
        result.respond_to?(:postal_code) ? result.postal_code : nil
      )
    end

    {
      zip: (postcode || postal),
      lat: result&.latitude,
      lon: result&.longitude
    }
  end
end