require 'ipgeobase'

describe Ipgeobase::GeoObject do
  subject { Ipgeobase::GeoObject.build(ip) }

  context 'valid ip' do
    let(:ip) { '178.204.73.174' }

    its(:ip) { is_expected.to eq(ip) }
  end

  context 'empty ip' do
    let(:ip) { '' }

    its(:ip) { is_expected.to be_nil }
  end

  context 'nil ip' do
    let(:ip) { nil }

    its(:ip) { is_expected.to be_nil }
  end

  context 'invalid ip' do
    let(:ip) { 'qwerty' }

    its(:ip) { is_expected.to be_nil }
  end

  context 'not found' do
    let(:ip) { '134.234.3.2' }

    its(:ip) { is_expected.to eq(ip) }
  end
end