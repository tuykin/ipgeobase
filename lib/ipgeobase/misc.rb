require "ipgeobase/ext_enum"
require "ipgeobase/array"
require "ipgeobase/string"

module Ipgeobase::Misc
  def self.main
    files = Dir.glob("*")

    res = files
          .reject { |f| f.start_with?('.') }
          .sort
          .middle
          .plural('s')
          .upcase

    puts res
    res
  end
end