# slightlybetterlotteryodds
Incredibly Slightly Better Odds (Maybe) for picking lottery balls

Your odds are basically impossible at winning a giant lottery but this might *slightly* increase your odds at winning as per this:

https://www.statisticshowto.com/odds-of-winning-the-lottery/

The combinations generated here will pick random numbers from the most frequently occurring balls for Mega Millions, Powerball, Cash4Life, NY Lotto (technically) and Yotta. This maybe changes your chances of winning from _less likely_ than getting hit by an asteroid to _maybe_ about as likely as getting hit by an asteroid (or not).

## Usage
    $ ./app.rb
Analyzes data, generates charts and outputs html/javascript for generating combinations.

OR

    $ ./get_data.rb
Grabs the most recent lottery data in CSV format: Powerball, Megaball, Cash4Life and NY Lotto

OR

    $ ./add_data.rb
Accepts command line input for yotta data and appends to the yotta.csv file

## Then...
Fire up your browser and load up any html file in output

## NY Lotto Note
NY Lotto was pretty confusing to me since I have never played it and probably don't plan to. I had to read the description several times to make sense of it.

You pick six balls, 1-59. The lottery consists of picking 6 balls, then a bonus 7th. The bonus 7th only comes into play to win second prize and no other. Since you can't pick this 7th ball, it doesn't fit with the methods for all the other lotteries, so I would not recommend using the picker on it.