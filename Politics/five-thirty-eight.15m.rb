#!/usr/bin/env ruby
# <bitbar.title>Election Tracker</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Chris Metcalf</bitbar.author>
# <bitbar.author.github>chrismetcalf</bitbar.author.github>
# <bitbar.desc>Scrapes election odds from FiveThirtyEight's election tracker</bitbar.desc>
# <bitbar.image>http://i.imgur.com/1NeqVZ6.png</bitbar.image>
# <bitbar.dependencies>ruby</bitbar.dependencies>
# <bitbar.abouturl>https://github.com/chrismetcalf/bitbar-plugins</bitbar.abouturl>

require 'open-uri'
require 'json'

electoral_votes = JSON::parse(open('https://projects.fivethirtyeight.com/2020-election-forecast/electoral_votes.json').read)
simulations = JSON::parse(open('https://projects.fivethirtyeight.com/2020-election-forecast/us_simulations.json').read)

biden_wins = simulations.first["simulations"].select{ |s| s["winner"] == "Biden" }.count

if biden_wins > 50
  puts ":thumbsup: #{biden_wins}%"
else
  puts ":imp: #{biden_wins}%"
end

puts "---"
puts "Electoral Votes:"
electoral_votes.first["candidates"].each do |c|
  puts "#{c["candidate"]}: #{c["mean"].round} (#{c["hi"]}/#{c["lo"]})"
end

puts "---"
puts "FiveThirtyEight | href=https://projects.fivethirtyeight.com/2020-election-forecast/"

puts "---"
puts "Refresh... | refresh"
