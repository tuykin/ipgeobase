module Ipgeobase
  class Sample
    def self.hello(name)
      name ||= 'World'
      "Hello, #{name}!"
    end
  end
end