class Lottery

  require 'csv'

  require_relative 'picker'

  attr_accessor :title

  attr_accessor :white_ball
  attr_accessor :yellow_ball
  attr_accessor :data_file
  attr_accessor :start_date

  attr_accessor :white_ball_counter
  attr_accessor :yellow_ball_counter

  attr_accessor :white_ball_mean
  attr_accessor :yellow_ball_mean
  attr_accessor :white_ball_standard_deviation
  attr_accessor :yellow_ball_standard_deviation

  attr_accessor :white_ball_candidates
  attr_accessor :yellow_ball_candidates

  attr_accessor :white_ball_selections
  attr_accessor :yellow_ball_selections

  def initialize(options = {})
    self.title = options[:title]

    self.white_ball = options[:white_ball]
    self.yellow_ball = options[:yellow_ball]

    self.data_file = "data/#{options[:data_file]}"
    self.start_date = Date.parse(options[:start_date]) if options[:start_date]

    self.white_ball_counter = generate_hash_counter(self.white_ball.range) if self.white_ball
    self.yellow_ball_counter = generate_hash_counter(self.yellow_ball.range) if self.yellow_ball
  end

  def generate_hash_counter(range)
    h = {}

    range.to_a.each do |el|
      h[el] = 0
    end
    
    h
  end

  def generate_combination
    picker = Picker.new(candidates: self.white_ball_candidates, quantity: self.white_ball.quantity)
    self.white_ball_selections = picker.pick

    picker = Picker.new(candidates: self.yellow_ball_candidates, quantity: self.yellow_ball.quantity)
    self.yellow_ball_selections = picker.pick
  end

  def selections_to_s
    output = "White Ball: #{self.white_ball_selections.sort}\n"
    output += "Yellow Ball: #{self.yellow_ball_selections.sort}\n"
  end

  def analyze(within_how_many_standard_deviations = 1)
    generate_histograms

    self.white_ball_mean = calculate_mean(white_ball_counter)
    self.white_ball_standard_deviation = calculate_standard_deviation(white_ball_counter, white_ball_mean)

    self.yellow_ball_mean = calculate_mean(yellow_ball_counter)
    self.yellow_ball_standard_deviation = calculate_standard_deviation(yellow_ball_counter, yellow_ball_mean)
    
    self.white_ball_candidates = find_candidates(white_ball_counter, white_ball_mean, white_ball_standard_deviation, within_how_many_standard_deviations)
    self.yellow_ball_candidates = find_candidates(yellow_ball_counter, yellow_ball_mean, yellow_ball_standard_deviation, within_how_many_standard_deviations)
  end

  def generate_histograms
    parse_data
  end

  def parse_data
    if self.title == "Mega Millions"
      parse_mega_millions_data
    elsif self.title == "Powerball"
      parse_powerball_data
    elsif self.title == "Yotta"
      parse_yotta_data
    elsif self.title == "Cash4Life"
      parse_cash4life_data
    end
  end

  def parse_mega_millions_data
    CSV.foreach(self.data_file, headers: true) do |row|
      row_date = Date::strptime(row['Draw Date'], "%m/%d/%Y")
      
      # TODO, should prob give the option to look at all data, not just since the current format
      if row_date >= start_date
        parse_winning_numbers( row['Winning Numbers'] ).each do |winning_number|
          self.white_ball_counter[winning_number.to_i] += 1
        end
        self.yellow_ball_counter[ row['Mega Ball'].to_i ] += 1
        # self.multiplier_counter[ row['Multiplier'].to_i ] += 1 if row['Multiplier']
      end
    end
  end

  def parse_powerball_data
    CSV.foreach(self.data_file, headers: true) do |row|
      row_date = Date::strptime(row['Draw Date'], "%m/%d/%Y")
      
      # TODO, should prob give the option to look at all data, not just since the current format
      if row_date >= start_date
        winning_numbers = parse_winning_numbers( row['Winning Numbers'][0..(row['Winning Numbers'].size - 1)] )
        winning_numbers.each do |winning_number|
          self.white_ball_counter[winning_number.to_i] += 1
        end

        self.yellow_ball_counter[winning_numbers.last.to_i] += 1
        # multiplier_counter[ row['Multiplier'].to_i ] += 1 if row['Multiplier']
      end
    end
  end

  def parse_yotta_data
    CSV.foreach(self.data_file, headers: true) do |row|
      row_date = Date.parse(row['EndingDate'])
      
      if row_date >= start_date
        6.times do |index|
          self.white_ball_counter[ row["Number#{index + 1}"].to_i ] += 1
        end
        
        self.yellow_ball_counter[ row['YottaBallNumber'].to_i ] += 1
      end
    end
  end

  def parse_cash4life_data
    CSV.foreach(self.data_file, headers: true) do |row|
      row_date = Date::strptime(row['Draw Date'], "%m/%d/%Y")
      
      if row_date >= start_date
        parse_winning_numbers(row['Winning Numbers']).each do |winning_number|
          self.white_ball_counter[winning_number.to_i] += 1
        end

        self.yellow_ball_counter[ row['Cash Ball'].to_i ] += 1
      end
    end
  end

  def parse_winning_numbers(str)
    str.split(" ")
  end

  def calculate_mean(h)
    # we'll assume that there is a value for each index
    sum = 0.0
    keys = h.keys
    keys.each do |key|
      sum += h[key]
    end

    sum / keys.size
  end

  def calculate_standard_deviation(h, mean)
    sum = 0.0

    keys = h.keys
    keys.each do |key|
      sum += (h[key] - mean) ** 2
    end

    Math.sqrt(sum / (keys.size - 1))
  end

  def find_candidates(counter, mean, standard_deviation, within_how_many)
    tmp_candidates = []

    counter.keys.each do |key|
      if counter[key].to_f >= (mean - standard_deviation * within_how_many)
        tmp_candidates << key
      end
    end
    
    tmp_candidates
  end

end