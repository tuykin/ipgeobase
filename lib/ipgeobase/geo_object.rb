require 'net/http'
require 'uri'
require 'nokogiri'
require 'ipaddr'

class Ipgeobase::GeoObject
  attr_reader :ip, :inetnum, :country, :city, :region, :district, :latitude, :longtitude

  def self.build(ip)
    return new({}) if ip.nil?

    begin
      IPAddr.new(ip)
    rescue IPAddr::InvalidAddressError
      return new({})
    end

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
    if !doc.xpath('//ip-answer/ip/message').empty?
      {
        ip: doc.xpath('//ip-answer/ip').attribute('value').text
      }
    else
      {
        ip: doc.xpath('//ip-answer/ip').attribute('value').text,
        inetnum: doc.xpath('//ip-answer/ip/inetnum').text,
        country: doc.xpath('//ip-answer/ip/country').text,
        city: doc.xpath('//ip-answer/ip/city').text,
        region: doc.xpath('//ip-answer/ip/region').text,
        district: doc.xpath('//ip-answer/ip/district').text,
        latitude: doc.xpath('//ip-answer/ip/lat').text,
        longtitude: doc.xpath('//ip-answer/ip/lng').text
      }
    end
  end
end