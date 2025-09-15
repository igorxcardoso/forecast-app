
require 'byebug'

def isAlphabeticPalindrome(code)
  alphabet = ('a'...'z').to_a
  
  codeOnlyLetter = code.split('').filter{|c| alphabet.include?(c.downcase)}
  len = codeOnlyLetter.length
  
  (0..len/2).each do |i|
    puts codeOnlyLetter
    if codeOnlyLetter[i]&.downcase != codeOnlyLetter[len-1-i]&.downcase
      return 0
    end
  end

  return 1
end


puts isAlphabeticPalindrome('an123a')