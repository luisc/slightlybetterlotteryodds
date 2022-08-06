#!/usr/bin/env ruby

require_relative 'lib/lottery'
require_relative 'lib/ball'

def write_chart_file(output_file, lottery)
  data = {
    title: lottery.title,
    start_date: lottery.start_date,

    white_ball_mean: lottery.white_ball_mean.round(2),
    white_ball_standard_deviation: lottery.white_ball_standard_deviation.round(2),

    yellow_ball_mean: lottery.yellow_ball_mean.round(2),
    yellow_ball_standard_deviation: lottery.yellow_ball_standard_deviation.round(2),

    labels_white_balls: lottery.white_ball_counter.keys,
    data_white_balls: lottery.white_ball_counter.values,

    labels_yellow_ball: lottery.yellow_ball_counter.keys,
    data_yellow_ball: lottery.yellow_ball_counter.values
  }

  file = File.open("template/chart.rhtml")
  file_data = file.read
  file.close
  File.write("output/#{output_file}", file_data % data)
end

def setup_lottery(title, white_ball_options, yellow_ball_options, data_file, output_file, start_date)
  lottery = Lottery.new(
    title: title,
    white_ball: Ball.new(range: white_ball_options[:range], quantity: white_ball_options[:quantity]),
    yellow_ball: Ball.new(range: yellow_ball_options[:range]),
    data_file: data_file,
    start_date: start_date
  )

  lottery.analyze
  write_chart_file(output_file, lottery)

  lottery
end

lotteries = [ setup_lottery(
  "Mega Millions",
  { range: 1..70, quantity: 5 },
  { range: 1..25 },
  "mega-millions.csv",
  "mega_millions.html",
  "2017-10-31"
) ]

lotteries << setup_lottery(
  "Powerball",
  { range: 1..69, quantity: 5 },
  { range: 1..26 },
  "powerball.csv",
  "powerball.html",
  "2015-10-07"
)

lotteries << setup_lottery(
  "Yotta",
  { range: 1..70, quantity: 6 },
  { range: 1..63 },
  "yotta.csv",
  "yotta.html",
  "2020-09-27"
)

lotteries << setup_lottery(
  "Cash4Life",
  { range: 1..60, quantity: 5 },
  { range: 1..4 },
  "cash4life.csv",
  "cash4life.html",
  "2014-06-16"
)

lotteries.each do |lottery|
  puts "How many combinations for #{lottery.title} would you like?"
  quantity = gets.chomp.to_i

  puts lottery.title
  quantity.times do
    lottery.generate_combination
    puts lottery.selections_to_s
  end
end

# puts "How many combinations for Mega Millions would you like?"
# quantity = gets.chomp.to_i

# puts "Mega Millions"
# quantity.times do
#   mega_millions.generate_combination
#   puts mega_millions.selections_to_s
# end

# puts "How many combinations for Yotta would you like?"
# quantity = gets.chomp.to_i

# puts "Yotta"
# quantity.times do
#   yotta.generate_combination
#   puts yotta.selections_to_s
# end
