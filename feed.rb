#! /usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'date'

doc = Nokogiri::HTML(open('https://github.com/carlgo11.atom'))
a = Hash.new { |h, k| h[k] = '' }

for k in 0..4 do
  a.store((Date.today - k).strftime('%Y-%m-%d'), 0)
end

i = 0
while doc.css('feed entry published').length > i && (Date.today - 5).strftime('%Y-%m-%d') <= doc.css('feed entry published')[i].content.split('T')[0]
  key = Date.parse(doc.css('feed entry published')[i].content).strftime('%Y-%m-%d')
  if doc.css('feed entry id')[i].content.to_s.include?('DeleteEvent') || !a.key?(key)
    i += 1
    next
  end

  a.store(key, a[key] + 1)
  i += 1
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

# Pass on activity to LIFX script
puts `python3 lifx.py #{c.map { |_k, v| v }.join(' ')}`
