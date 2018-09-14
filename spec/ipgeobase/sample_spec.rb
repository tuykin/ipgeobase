require 'ipgeobase'

describe Ipgeobase::Sample do
  describe ".hello" do
    it do
      expect(Ipgeobase::Sample.hello(nil)).to eq("Hello, World!")
      expect(Ipgeobase::Sample.hello("Nick")).to eq("Hello, Nick!")
    end
  end
end