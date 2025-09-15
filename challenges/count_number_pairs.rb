# LINK: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/count-number-pairs/problem?isFullScreen=true



def countAffordablePairs(prices, budget)
  count = 0
  (0..prices.length).each do |i|
    (i+1..prices.length-1).each do |j|
      puts "#{prices[i]} #{prices[j]}"
      count += 1 if i < j && prices[i] + prices[j] <= budget
    end
  end
  count
end

puts countAffordablePairs([1, 2, 3, 4, 5], 7)