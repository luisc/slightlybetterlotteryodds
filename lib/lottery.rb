class Lottery

  attr_accessor :white_ball
  attr_accessor :yellow_ball
  attr_accessor :data_file
  attr_accessor :start_date

  attr_accessor :white_ball_selections
  attr_accessor :yellow_ball_selections

  def initialize(options)
    white_ball = options[:white_ball]
    yellow_ball = options[:yellow_ball]
    data_file = options[:data_file]
    start_date = options[:start_date]
  end

  def generate_combination
    analyze

    picker = Picker.new(candidates: white_ball.candidates, quantity: white_ball.quantity)
    white_ball_selections = picker.pick

    picker = Picker.new(candidates: yellow_ball.candidates, quantity: yellow_ball.quantity)
    yellow_ball_selections = picker.pick
  end

  def selections_to_s
    output = "White Ball: #{white_ball_selections}\n"
    output += "Yellow Ball: #{yellow_ball_selections}"
  end

  def analyze(within_how_many_standard_deviations = 1)
    # get counts of each occurrence
    # find mean of data
    # find standard deviation
    # find values within lower bound of standard deviations
  end

end