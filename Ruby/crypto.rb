#!/usr/bin/ruby

require './aellus/stringutil'
require './aellus/crypto/cipher'
require 'rubygems'

def main
    message = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    puts "Message: #{StringUtil.hex2ascii message}\n"
    
    scoreHash = Hash.new
    
	for i in 31..126
        hex = i.to_s(16).rjust(2,'0')
        cipher = Ciphers.generateMatchingKey(message, hex)
        #puts "Cipher:  #{cipher}\n"
        xorResult = StringUtil.xorHex(message, cipher)
        #puts "XOR:     #{xorResult}\n"
        
        plaintext = StringUtil.hex2ascii xorResult
        
        score = StringUtil.scoreEnglishness plaintext
        scoreHash[plaintext] = score
    #    puts "[#{hex}] Message: #{plaintext} = Score (#{score.to_s.rjust(5,' ')})\n"
    end
    
    scoreHash = scoreHash.sort_by { |message, score| score }
    
    for pair in scoreHash
        puts pair
    end
end

main