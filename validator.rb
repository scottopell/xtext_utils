#!/usr/bin/ruby
require 'JSON'
require 'stringio'
require 'uri'
require 'net/http'

file_contents = IO.read ARGF.argv[0]

params_str = "?resource=text.mydsl&fullText=#{URI.escape(file_contents)}"
uri = URI.parse "http://localhost:8080/xtext-service/validate#{params_str}"
res = Net::HTTP.post_form uri, {}

json = JSON.parse res.body


s = StringIO.new
json['issues'].each do |issue|
  s<< ARGF.argv[0]
  s << ': '
  s << issue['line']
  s << ': '
  s << issue['description']
  s << "\n"
end
puts s.string
