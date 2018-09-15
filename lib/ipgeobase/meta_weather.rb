require 'ostruct'

class Ipgeobase::MetaWeather
  URL = "https://www.metaweather.com/api"

  def self.weather_for(location_id)
    uri = URI.parse("#{URL}/location/#{location_id}/")
    response = Net::HTTP.get_response(uri)
    response_hash = JSON.parse(response.body)
    map(response_hash)
  end

  private

  def self.map(response_hash)
    weather = response_hash['consolidated_weather'][0]
    OpenStruct.new(weather)
  end
end