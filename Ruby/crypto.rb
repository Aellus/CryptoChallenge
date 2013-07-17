require 'rubygems'

def main
    message = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
    puts "Message: #{hex2ascii message}\n"
    
    scoreHash = Hash.new
    
	for i in 31..126
        hex = i.to_s(16).rjust(2,'0')
        cipher = generateKey message, hex
        #puts "Cipher:  #{cipher}\n"
        xorResult = xorHex(message, cipher)
        #puts "XOR:     #{xorResult}\n"
        
        plaintext = hex2ascii xorResult
        
        score = scoreEnglishness plaintext
        scoreHash[plaintext] = score
    #    puts "[#{hex}] Message: #{plaintext} = Score (#{score.to_s.rjust(5,' ')})\n"
    end
    
    scoreHash = scoreHash.sort_by { |message, score| score }
    
    for pair in scoreHash
        puts pair
    end
end

def generateKey input, character
    i = 0
    key = ""
    while i < input.length do
        key += character
        i += character.length
    end
    return key
end

def scoreEnglishness ascii_input
    asciiFreq = "zqxjvkpybcgmfuwlrdsinoahte"
    freqs =      ""
    asciiFreq.each_char { |c|
        freqs += c.upcase + c
    }
    
    ascii_text = String.new ascii_input
    
    score = 0
    ascii_text.each_char { |c|
        index = freqs.index(c)
        if index.nil?
            score -= 15
        elsif c == ' '
            score += 10
        else
            score += index
        end
    }
    return score
end

def xorHex str1, str2
    if str1.length != str2.length
        raise StandardError("XOR Inputs are not the same length!")
    end
    xorstr = ""
    binstr1 = hex2binary str1
    binstr2 = hex2binary str2
    i = 0
    while i < binstr1.length do
        sum = binstr1[i].to_i + binstr2[i].to_i
        xorResult = sum == 1 ? 1 : 0
        xorstr += xorResult.to_s
        i += 1
    end
    return "%02x" % xorstr.to_i(2)
end

def hex2ascii hex_input
    hex_string = String.new hex_input
    
    bin_string = hex2binary hex_string
    
    return binary2ascii bin_string
end

def hex2binary hex_input
    hex_string = String.new hex_input
    binary_string = ""
    while hex_string.size > 0
        char = hex_string.slice!(0)
        binary = char.to_i(16).to_s(2).rjust(4,'0')
#        puts "Unpacked '#{char}' into bits '#{binary}'\n"
        binary_string += binary
    end
    return binary_string
end

def binary2ascii binary_input
    binary_string = String.new binary_input
    ascii_string = ""
    while binary_string.size > 0 do
        integer = binary_string.slice!(0..7).to_i(2)
        ascii = [integer].pack('C')
#        puts "Converted '#{integer}' to '#{ascii}'\n"
        ascii_string += (integer > 31 && integer < 128 ? ascii : '?')
    end
    return ascii_string
end

def binary2base64 binary_input
    binary_string = String.new binary_input
    base64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    base64string = ""
    while binary_string.size > 0
        slice = binary_string.slice!(0..5)
        index = slice.to_i(2)
        base = base64chars[index]
#        puts "Binary slice '#{slice}' converted to index '#{index}' which maps to Base64 '#{base}'\n"
        base64string += base
    end
    return base64string
end

main