#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'date'

if ENV['GITHUB_USER'].nil?
  abort("Error: Set environment variable 'GITHUB_USER'!")
end

begin
  doc = Nokogiri::HTML(open("https://github.com/#{ENV['GITHUB_USER']}.atom"))
rescue OpenURI::HTTPError => e
  abort("Error: 404 - Couldn't fetch user activity. Double check the spelling?") if e.message == '404 Not Found'
  raise e
end

active_days = Array.new(5, 0)

doc.css('feed entry published').each do |entry|
  diff = Date.today - Date.iso8601(entry.content)
  break if diff >= 5

  active_days[diff] += 1
end

# Get max commits
max = active_days.max
output = []

if max.zero?
  output = Array.new(5, 0)
else
  # Set color level for each day
  active_days.each do |value|
    output = case value
             when max * 0.8..max
               [*output, 4]
             when max * 0.65..max * 0.8
               [*output, 3]
             when max * 0.4..max * 0.65
               [*output, 2]
             when 1..max * 0.4
               [*output, 1]
             else
               [*output, 0]
             end
  end
  output = output.reverse if ENV['REVERSE']
end

puts "Color levels: #{output.join(' ')}"

# Pass color levels to LifxLAN Python script
puts `python3 lifx.py #{output.join(' ')}`
