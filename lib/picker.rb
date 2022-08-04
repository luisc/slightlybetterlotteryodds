class Picker
  
  attr_accessor :candidates
  attr_accessor :quantity

  def initialize(options)
    self.candidates = options[:candidates]
    self.quantity = options[:quantity] || 1
  end

  def pick
    combination = []
    tmp_candidates = self.candidates.to_a
    
    quantity.times do
      picked = tmp_candidates[ Random.rand(tmp_candidates.size) ]
      combination << picked
      tmp_candidates -= [picked]
    end

    combination
  end
end