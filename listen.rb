#! /usr/bin/env ruby
require 'socket'

puts "Ready for new connections."
server = TCPServer.open(6289)

loop do
  client = server.accept
  puts "New connection!"
  client.puts(`ruby feed.rb`)
  client.close
end
