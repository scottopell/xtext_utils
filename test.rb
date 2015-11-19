#!/usr/bin/ruby

module Tty extend self
  def blue; bold 34; end
  def green; bold 32; end
  def white; bold 39; end
  def red; underline 31; end
  def reset; escape 0; end
  def bold n; escape "1;#{n}" end
  def underline n; escape "4;#{n}" end
  def escape n; "\033[#{n}m" if STDOUT.tty? end
end

def check_output output, expected_output, cmd
  if output == expected_output
    puts "\t\t#{Tty.green}OKAY#{Tty.reset}"
    return 0
  else
    puts "\t\t#{Tty.red}FAILED#{Tty.reset}"
    puts "\t\tCommand was: #{cmd}"
    puts "\t\tOutput was:\t#{output}"
    puts "\t\tExpected was:\t#{expected_output}"
    return 1
  end
end

num_failures = 0

puts "Validation Test"

cmd = "./validator.rb valid.mydsl"
output = `#{cmd}`
expected_output = "\n"
puts "\t#{Tty.blue}valid input:"

num_failures += check_output output, expected_output, cmd


cmd = "./validator.rb invalid.mydsl"
output = `#{cmd}`
expected_output = "invalid.mydsl: 1: mismatched input '<EOF>' expecting '!'\n"
puts "\t#{Tty.blue}invalid input:"

num_failures += check_output output, expected_output, cmd


puts "Completion Test"

cmd = "cat completion_stub.mydsl | ./complete.rb 3"
output = `#{cmd}`
expected_output = "Hello\n"
puts "\t#{Tty.blue}Basic Completion"

num_failures += check_output output, expected_output, cmd


puts "Formatter Test"

cmd = "cat test.mydsl | ./formatter.sh"
output = `#{cmd}`
expected_output = "Hello\n"
puts "\t#{Tty.blue}Basic Formatting"

num_failures += check_output output, expected_output, cmd

exit num_failures
