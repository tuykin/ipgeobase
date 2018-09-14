describe Ipgeobase do
  describe '.get' do
    subject { Ipgeobase.get(ip) }

    context 'ip is valid' do
      let(:ip) { '178.204.73.174' }

      it { is_expected.to be_a(Ipgeobase::GeoObject) }
    end

    context 'ip is invalid' do
      let(:ip) { 'qwerty' }

      it { is_expected.to be_a(Ipgeobase::GeoObject) }
    end

    context 'ip is not found' do
      let(:ip) { 'qwerty' }

      it { is_expected.to be_a(Ipgeobase::GeoObject) }
    end
  end
end