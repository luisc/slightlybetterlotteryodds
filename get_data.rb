#!/usr/bin/env ruby

require 'date'

data_path = "data"

def write_lottery_file(src, output)
  # if you don't have curl, I dunno!
  puts "grabbing file...\n#{src}"
  `curl -o #{output} #{src}`
  puts "wrote: #{output}"
end

write_lottery_file(
  "https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD",
  "#{data_path}/mega-millions.csv"
)

write_lottery_file(
  "https://data.ny.gov/api/views/dhwa-m6y4/rows.csv?accessType=DOWNLOAD&sorting=true",
  "#{data_path}/powerball.csv"
)
