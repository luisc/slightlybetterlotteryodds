#!/usr/bin/env ruby

require 'date'
require 'csv'

require_relative 'lib/lottery'

def get_new_row
  l = Lottery.new
  new_row = []

  puts "Enter the drawing date"
  new_row << gets.chomp

  puts "Enter winning white ball numbers"
  new_row << l.parse_winning_numbers(gets.chomp)

  puts "Enter winning yotta ball number"
  new_row << gets.chomp

  # new_row.flatten

  puts "Enter 1 to enter another row, anything else to quit"

  get_new_row if gets.chomp.to_i == 1
end

get_new_row