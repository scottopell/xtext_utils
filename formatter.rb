#!/usr/bin/ruby
require 'JSON'
require 'stringio'
require 'uri'
require 'net/http'

file_contents = $stdin.read

uri = URI.parse 'http://localhost:8080'
req = Net::HTTP::Post.new 'http://localhost:8080/xtext-service/format'

req.set_form_data resource: 'text.mydsl',
  full_text: URI.escape(file_contents)

res = Net::HTTP.new(uri.host, uri.port).start { |http| http.request(req) }
json = JSON.parse res.body

puts json['formattedText']
