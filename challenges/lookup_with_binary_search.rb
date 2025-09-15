# LINK: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/lookup-with-binary-search/problem?isFullScreen=true

# Given a sorted array of distinct integers and a target value, return the index of the target or -1 if not found.


def binarySearch(nums, target)
  # Write your code here
  
  nums.each_with_index do |num, index|
    if num == target
      return index
    end
  end
  return -1
end


puts binarySearch( [2, 4, 6, 8, 10, 12, 14, 16], 16)