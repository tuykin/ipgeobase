require 'ipgeobase'

describe Ipgeobase::GeoObject do
  let(:ip) { '178.204.73.174' }

  it do
    obj = Ipgeobase::GeoObject.build(ip)
    expect(obj.ip).to eq(ip)
    expect(obj.city).to eq("Казань")
  end
end