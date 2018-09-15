class Ipgeobase::Client
  URL = 'http://ipgeobase.ru:7020/geo'

  def self.get_response(ip)
    uri = URI.parse("#{URL}?ip=#{ip}")
    Net::HTTP.get_response(uri)
  end
end