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
      picked = Random.rand(tmp_candidates.size)
      combination << tmp_candidates[picked]
      tmp_candidates.delete(picked)
    end

    combination
  end
end