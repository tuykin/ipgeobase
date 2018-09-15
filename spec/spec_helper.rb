require 'ipgeobase'

RSpec.configure do |config|
  def load_fixture(filename)
    File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
  end
end