#!/usr/bin/ruby

require './aellus/stringutil'
require 'rubygems'

message = "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"

puts "Using StringUtil.hex2base64(#{message})"

message64 = StringUtil.hex2base64(message)

puts "Base64: #{message64}"