class String
  def plural(symbol)
    self.end_with?('s') ? self : "#{self}#{symbol}"
  end
end