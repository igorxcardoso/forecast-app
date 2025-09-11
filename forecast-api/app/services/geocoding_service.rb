class GeocodingService
  class AddressNotFound < StandardError; end

  def self.extract_zip_and_coords(postal)
    raise ArgumentError, 'ZIP code blank' if postal.empty?

    result = Geocoder.search(postal).first
    raise AddressNotFound, "Could not find ZIP code" unless result

    postcode = (result.data.dig('address', 'postcode') if result.data) || (
      result.respond_to?(:postal_code) ? result.postal_code : nil
    )

    {
      zip: (postcode || postal),
      lat: result&.latitude,
      lon: result&.longitude,
      address: result&.address
    }
  end
end