class Picker
  
  attr_accessor :candidates
  attr_accessor :quantity

  def initialize(options)
    self.candidates = options[:candidates]
    self.quantity = options[:quantity] || 1
  end

  def pick
    combination = []
    tmp_range = range.to_a

    quantity.times do
      combination << tmp_range[picked = Random.rand(tmp_range.size)]
      tmp_range.delete(picked)
    end

    combination
  end
end