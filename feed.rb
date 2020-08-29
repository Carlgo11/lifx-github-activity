#! /usr/bin/env ruby
# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'date'

abort("Error: Set environment variable 'GITHUB_USER'!") if ENV['GITHUB_USER'].nil?

html = Nokogiri::HTML.parse(URI.open("https://github.com/#{ENV['GITHUB_USER']}"))

active_days = Array.new(5, 0)

# Get last 5 items in array
html.css('.day').each do |item|
  diff = Integer(Date.today - Date.iso8601(item['data-date']))
  active_days[diff] = Integer(item['data-count']) if diff < 5
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