# LINK: https://www.hackerrank.com/contests/mock-interviews-software-engineer-coding/challenges/string-difference-1-4/problem?isFullScreen=true
# Given two strings, str1, and str2, where str1 contains exactly one character more than str2, find the indices of the characters in str1 that can be removed to make str1 equal to str2. Return the array of indices in increasing order. If it is not possible, return the array \[-1\].

def getRemovableIndices(str1, str2)
  targetIndexes = []

  (0...str1.length).each do |i|
    # Vai pegar uma string com inicio de st1 e o final de str2
    candidate = str1[0...i] + str1[i+1..-1]
    targetIndexes << i if candidate == str2
  end

  targetIndexes.empty? ? [-1] : targetIndexes
end

str1 = "abdggdaa"
str2 = "abdggda"

puts getRemovableIndices(str1, str2)