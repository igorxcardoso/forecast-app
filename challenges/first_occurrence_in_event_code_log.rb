# LINK: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/first-occurrence-in-event-code-log/problem?isFullScreen=true

# Given a sorted array of integers that may contain duplicates, return the index of the first occurrence of a target value or -1 if not found.


def findFirstOccurrence(nums, target)
  nums.each_with_index do |num, index|
    if num == target
      # Retorna o primeiro que encontrar
      return index
    end
  end
  return -1
end