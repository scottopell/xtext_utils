#!/usr/bin/ruby
require 'JSON'
require 'stringio'
require 'uri'
require 'net/http'

file_contents = $stdin.read

params_str = "?resource=text.mydsl&fullText=#{URI.escape(file_contents)}"
uri = URI.parse "http://localhost:8080/xtext-service/format#{params_str}"
res = Net::HTTP.post_form uri, {}

json = JSON.parse res.body

puts json['formattedText']
