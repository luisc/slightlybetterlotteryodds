#!/usr/bin/env ruby

# data downloaded from
# https://data.ny.gov/Government-Finance/Lottery-Mega-Millions-Winning-Numbers-Beginning-20/5xaw-6ayf

# have spreadsheet plotting number frequency
# https://docs.google.com/spreadsheets/d/1-fH3aBdP1lufHgxRqJIdWrwVMfX3ezH-Iv7VxdMmk78/edit#gid=870409625

# from an arbitrary 30+ occurance frequency, select five random numbers
# for now, just take a ballpark from the eyeballing
# megaball number was threshold of > 15
# multiplier number was for greater than 100

require 'json'
require 'csv'
require 'date'

def ball_generator(range, exclude)
  range.to_a - exclude
end

def select_ball(balls)
  balls[ Random.rand(balls.size) ]
end

def parse_winning_numbers(str)
  str.split(" ")
end

def generate_hash_counter(range)
  h = {}

  range.to_a.each do |el|
    h[el] = 0
  end
  
  h
end

# TODO revise with looking at analyzing the data
# this was originally done with just looking at a histogram of the values
def find_candidates(h, threshold)
  candidates = []
  h.each_key do |counter|
    if h[counter] >= threshold
      candidates << counter
    end
  end

  candidates
end

def generate_combination(whiteball_candidates, megaball_candidates, multiplier_candidates)
  selected_whiteballs = []

  5.times do
    selected_whiteballs << select_ball(whiteball_candidates)
    whiteball_candidates -= [selected_whiteballs.last]
  end

  {
    selected_whiteballs: selected_whiteballs.sort,
    selected_megaballs: select_ball(megaball_candidates),
    selected_multiplier: select_ball(multiplier_candidates)
  }
end

# on 10/31/2017 the format changed to
# 5 balls 1-70, 1 ball 1-25
# grab data only from then
# https://en.wikipedia.org/wiki/Mega_Millions#October_2017_format/price_point_change
start_date = Date.parse('2017-10-31')
whiteball_counter = generate_hash_counter(1..70)
megaball_counter = generate_hash_counter(1..25)
multiplier_counter = generate_hash_counter(2..5)

CSV.foreach('data/mega-millions.csv', headers: true) do |row|
  row_date = Date::strptime(row['Draw Date'], "%m/%d/%Y")
  
  # TODO, should prob give the option to look at all data, not just since the current format
  if row_date >= start_date
    parse_winning_numbers( row['Winning Numbers'] ).each do |winning_number|
      whiteball_counter[winning_number.to_i] += 1
    end
    megaball_counter[ row['Mega Ball'].to_i ] += 1
    multiplier_counter[ row['Multiplier'].to_i ] += 1 if row['Multiplier']
  end
end

counters = {
  labels_whiteballs: whiteball_counter.keys,
  data_whiteballs: whiteball_counter.values,

  labels_megaballs: megaball_counter.keys,
  data_megaballs: megaball_counter.values,

  labels_multipliers: multiplier_counter.keys,
  data_multipliers: multiplier_counter.values
}

puts "Opening up template"
file = File.open("template/chart.rhtml")
file_data = file.read
file.close

puts "Writing data"
File.write("output/index.html", file_data % counters)

# currently within 1 std deviation (lower bound only)
whiteball_candidates = find_candidates(whiteball_counter, 29)
megaball_candidates = find_candidates(megaball_counter, 16)
multiplier_candidates = find_candidates(multiplier_counter, 100)

puts "How many numbers to generate?"
quantity = gets.chomp.to_i

quantity.times do |index|
  combination = generate_combination(whiteball_candidates, megaball_candidates, multiplier_candidates)

  puts "-" * 12
  puts "Combination: #{index + 1}"
  p "whiteballs: #{combination[:selected_whiteballs]}"
  p "megaball: [#{combination[:selected_megaballs]}]"
  p "multiplier: [#{combination[:selected_multiplier]}]"

  # whiteball_candidates -= combination[:selected_whiteballs]
  # megaball_candidates -= [combination[:selected_megaballs]]
end

puts "-" * 12


