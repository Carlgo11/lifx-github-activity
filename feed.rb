#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'date'
doc = Nokogiri::HTML(open('https://github.com/carlgo11.atom'))

i = 0
a = Hash.new { |h, k| h[k] = '' }

while doc.css('feed entry published').length > i && (Date.today - 5).strftime('%Y-%m-%d') <= doc.css('feed entry published')[i].content.split('T')[0]

  key = Date.parse(doc.css('feed entry published')[i].content).strftime('%Y-%m-%d')

  if a[key] != ''
    (b = Integer(a[key]) + 1)
    a.store(key, b)
  else
    a.store(key, 1)
  end

  i += 1
end

# Get max commits
max = a.sort_by { |_key, value| value }.to_a.last[1]
puts "most commits a day: #{max}"

a.each do |key, value|
  puts "#{key} #{value}"
end
