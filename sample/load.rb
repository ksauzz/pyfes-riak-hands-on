#!/usr/bin/env ruby
require 'rubygems'
require 'riak'

client = Riak::Client.new(
  #:protocol => "pbc",
  :nodes => [
    {:host => '127.0.0.1', :http_port => 10018},
    {:host => '127.0.0.1', :http_port => 10028},
    {:host => '127.0.0.1', :http_port => 10038},
    {:host => '127.0.0.1', :http_port => 10048}
])

bucket = client.bucket("demo")

words = []

File.open('/usr/share/dict/words', 'r') do |file|
  while (line = file.gets)
    line = line.tr("\n", "")
    words.push(line.to_s)
  end
end

1.upto(2000000) do |num|
  object = Riak::RObject.new(bucket, num)
  object.content_type = 'application/json'
  object.data = {:id => num, :random_word => words[rand(words.length)]}
  object.store
  puts "Storing bucket/key: #{bucket.name}/#{num.to_s}, data: #{object.raw_data}"
  sleep 0.01
end
