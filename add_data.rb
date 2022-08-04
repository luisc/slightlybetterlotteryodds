#!/usr/bin/env ruby

require 'date'
require 'csv'

require_relative 'lib/lottery'

def get_new_row
  l = Lottery.new
  new_row = []

  puts "Enter the drawing date"
  new_row << Date::strptime(gets.chomp, "%m/%d/%y")

  puts "Enter winning white ball numbers"
  new_row << l.parse_winning_numbers(gets.chomp)

  puts "Enter winning yotta ball number"
  new_row << gets.chomp

  CSV.open("data/yotta.csv", "ab") do |data|
    data << new_row.flatten
  end

  puts "Enter 1 to enter another row, anything else to quit"

  get_new_row if gets.chomp.to_i == 1
end

get_new_row