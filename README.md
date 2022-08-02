# slightlybetterlotteryodds
Incredibly Slightly Better Odds (Maybe) for picking lottery balls

Your odds are basically impossible at winning Mega Millions but this might *slightly* increase your odds at winning as per this:

https://www.statisticshowto.com/odds-of-winning-the-lottery/

The scripts here will pick random numbers from the most frequently occurring balls for Mega Millions and Powerball. This maybe changes your chances of winning from _less likely_ than getting hit by an asteroid to _maybe_ about as likely as getting hit by an asteroid (or not).

* get_data.rb grabs the most recent lottery data in CSV format: Powerball and Megaball
* mega_millions.rb parses that data and sums up the occurrences of each ball (being deprecated as I write this)
* app.rb (in progress) will load up data, analyze it and generate combinations by excluding data outside of X standard deviations (lower bound only)


