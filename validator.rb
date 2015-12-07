#!/usr/bin/ruby
require 'JSON'
require 'stringio'
require 'uri'
require 'net/http'

file_contents = IO.read ARGF.argv[0]

uri = URI.parse 'http://localhost:8080'
req = Net::HTTP::Post.new 'http://localhost:8080/xtext-service/validate'

req.set_form_data resource: 'text.mydsl',
  full_text: URI.escape(file_contents)

res = Net::HTTP.new(uri.host, uri.port).start { |http| http.request(req) }

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
