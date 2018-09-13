require 'oop'

describe Oop::Sample do
  describe ".hello" do
    it do
      expect(Oop::Sample.hello(nil)).to eq("Hello, World!")
      expect(Oop::Sample.hello("Nick")).to eq("Hello, Nick!")
    end
  end
end