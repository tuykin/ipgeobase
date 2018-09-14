require 'net/http'
require 'uri'
require 'nokogiri'

class Ipgeobase::GeoObject
  attr_reader :ip, :inetnum, :country, :city, :region, :district, :lat, :lng

  def self.build(ip)
    response = get_response(ip)
    doc = parse_response(response)
    obj = build_object(doc)
    new(obj)
  end

  def initialize(obj)
    obj.each do |k, v|
      instance_variable_set("@#{k}", v)
    end
  end

  private

  def self.get_response(ip)
    uri = URI.parse("http://ipgeobase.ru:7020/geo?ip=#{ip}")
    Net::HTTP.get_response(uri)
  end

  def self.parse_response(response)
    Nokogiri::XML(response.body)
  end

  def self.build_object(doc)
    {
      ip: doc.xpath('//ip-answer/ip').attribute('value').text,
      inetnum: doc.xpath('//ip-answer/ip/inetnum').text,
      country: doc.xpath('//ip-answer/ip/country').text,
      city: doc.xpath('//ip-answer/ip/city').text,
      region: doc.xpath('//ip-answer/ip/region').text,
      district: doc.xpath('//ip-answer/ip/district').text,
      lat: doc.xpath('//ip-answer/ip/lat').text,
      lng: doc.xpath('//ip-answer/ip/lng').text
    }
  end
end