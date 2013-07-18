#!/usr/bin/ruby

require 'rubygems'

module Ciphers
    # Generates a key out of the repeated characters to match the length of the input
    def Ciphers.generateMatchingKey input, character
        i = 0
        key = ""
        while i < input.length do
            key += character
            i += character.length
        end
        return key
    end
end