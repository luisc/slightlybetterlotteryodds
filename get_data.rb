#!/usr/bin/env ruby

require 'date'

data_path = "data"

def write_lottery_file(src, output)
  # if you don't have curl, I dunno!
  puts "grabbing file...\n#{src}"
  `curl -o data/#{output} #{src}`
  puts "wrote: #{output}"
end

lotteries = [
  {
    title: "Mega Millions",
    src: "https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD",
    output: "mega-millions.csv"
  },

  {
    title: "Powerball",
    src: "https://data.ny.gov/api/views/d6yy-54nr/rows.csv?accessType=DOWNLOAD&sorting=true",
    output: "powerball.csv"
  },

  {
    title: "Cash4Life",
    src: "https://data.ny.gov/api/views/kwxv-fwze/rows.csv?accessType=DOWNLOAD&sorting=true",
    output: "cash4life.csv"
  },

  {
    title: "NY Lotto",
    src: "https://data.ny.gov/api/views/6nbc-h7bj/rows.csv?accessType=DOWNLOAD&sorting=true",
    output: "ny_lotto.csv"
  }
]

lotteries.each do |lottery|
  puts lottery[:title]
  write_lottery_file(lottery[:src], lottery[:output])
  puts "Waiting a sec..."
  sleep(1)
end


