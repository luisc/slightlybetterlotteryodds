class Ball

  attr_accessor :range
  attr_accessor :quantity

  def initialize(options)
    self.range = options[:range]
    self.quantity = options[:quantity] || 1
  end

end