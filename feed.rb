#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'date'

a = Hash.new { |h, k| h[k] = '' }

for k in 0..4 do
  a.store((Date.today - k).strftime('%Y-%m-%d'), 0)
end

document = Nokogiri::HTML.parse(URI.open("https://github.com/#{ENV['GITHUB_USER']}"))

# Get last 5 items in array
document.css('.day').each do |item|
  next if (Date.today - Date.iso8601(item['data-date'])) >= 5
  a.store(item['data-date'], Integer(item['data-count']))
end

# New list setting the color range
c = Hash.new { |h, k| h[k] = '' }

# Get max commits
max = a.sort_by { |_key, value| value }.to_a.last[1]

# Set color level for each day
a.each do |key, value|
  case value
  when max * 0.8..max
    c.store(key, 4)
  when max * 0.65..max * 0.8
    c.store(key, 3)
  when max * 0.4..max * 0.65
    c.store(key, 2)
  when 1..max * 0.4
    c.store(key, 1)
  else
    c.store(key, 0)
  end
end

puts c
# Pass on activity to LIFX script
puts `python3 lifx.py #{c.map { |_k, v| v }.join(' ')}`
