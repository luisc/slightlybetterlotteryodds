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

mega_millions = Lottery.new(
  title: "Mega Millions",
  white_ball: Ball.new(range: 1..70, quantity: 5),
  yellow_ball: Ball.new(range: 1..25),
  data_file: "data/mega-millions.csv",
  start_date: "2017-10-31"
)
mega_millions.analyze
write_chart_file("mega_millions.html", mega_millions)

powerball = Lottery.new(
  title: "Powerball",
  white_ball: Ball.new(range: 1..69, quantity: 5),
  yellow_ball: Ball.new(range: 1..26),
  data_file: "data/powerball.csv",
  start_date: "2015-10-07"
)
powerball.analyze
write_chart_file("powerball.html", powerball)

yotta = Lottery.new(
  title: "Yotta",
  white_ball: Ball.new(range: 1..70, quantity: 6),
  yellow_ball: Ball.new(range: 1..63),
  data_file: "data/yotta.csv",
  start_date: "2020-09-27"
)
yotta.analyze
write_chart_file("yotta.html", yotta)

puts "How many combinations for Powerball would you like?"
quantity = gets.chomp.to_i

puts "Powerball"
quantity.times do
  powerball.generate_combination
  puts powerball.selections_to_s
end

puts "How many combinations for Mega Millions would you like?"
quantity = gets.chomp.to_i

puts "Mega Millions"
quantity.times do
  mega_millions.generate_combination
  puts mega_millions.selections_to_s
end

puts "How many combinations for Yotta would you like?"
quantity = gets.chomp.to_i

puts "Yotta"
quantity.times do
  yotta.generate_combination
  puts yotta.selections_to_s
end
