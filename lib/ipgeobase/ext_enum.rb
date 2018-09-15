module Ipgeobase::ExtEnum
  def middle
    middle_index = (self.length / 2).round
    self.at(middle_index)
  end
end