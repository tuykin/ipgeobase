require 'ipgeobase'

describe Ipgeobase::GeoObject do
  let(:ip) { '178.204.73.174' }

  it do
    obj = Ipgeobase::GeoObject.build(ip)
    expect(obj.ip).to eq(ip)
    expect(obj.city).to eq("Казань")
    expect(obj.country).to eq("RU")
    expect(obj.latitude).to_not be_nil
    expect(obj.longtitude).to_not be_nil
  end
end