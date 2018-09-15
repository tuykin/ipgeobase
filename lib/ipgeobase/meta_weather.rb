require 'ostruct'

class Ipgeobase::MetaWeather
  URL = "https://www.metaweather.com/api"

  def self.weather_by_name(location_name)
    location = search_for_location(location_name)
    return {} if location.nil?
    weather_by_id(location.woeid)
  end

  def self.weather_by_id(location_id)
    uri = URI.parse("#{URL}/location/#{location_id}/")
    response = Net::HTTP.get_response(uri)
    response_hash = JSON.parse(response.body)
    map_weather(response_hash)
  end

  def self.search_for_location(query)
    uri = URI.parse("#{URL}/location/search/?query=#{query}/")
    response = Net::HTTP.get_response(uri)
    response_hash = JSON.parse(response.body)
    map_location(response_hash)
  end

  private

  def self.map_weather(response_hash)
    item = response_hash['consolidated_weather'][0]
    OpenStruct.new(item)
  end

  def self.map_location(response_hash)
    item = response_hash[0]
    OpenStruct.new(item)
  end
end