#!/usr/bin/env ruby

require 'date'

today = Date.today.to_s
output = "data/mega-millions.csv"
src = "https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD"

# if you don't have curl, I dunno!
puts "grabbing file..."
`curl -o #{output} #{src}`
puts "got it!"
