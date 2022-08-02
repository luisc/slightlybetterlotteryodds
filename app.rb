#!/usr/bin/env ruby

require_relative 'lib/picker'

mega_millions = Lottery.new(
  title: "Mega Millions",
  white_ball: Ball.new(range: 1..70, quantity: 5),
  yellow_ball: Ball.new(range: 1..25),
  data_file: "data/mega-millions.csv",
  start_date: "2017-10-31"
)

powerball = Lottery.new(
  title: "Mega Millions",
  white_ball: Ball.new(range: 1..69, quantity: 5),
  yellow_ball: Ball.new(range: 1..26),
  data_file: "data/powerball.csv",
  start_date: "2015-10-07"
)

puts "How many combinations for Powerball would you like?"
quantity = gets.chomp.to_i
quantity.times do
  powerball.generate_combination
end

puts "How many combinations for Mega Millions would you like?"
quantity = gets.chomp.to_i
quantity.times do
  mega_millions.generate_combination
end
