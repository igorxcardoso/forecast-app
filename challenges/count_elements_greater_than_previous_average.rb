# LINK: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/count-elements-greater-than-previous-average/problem?isFullScreen=true

def countResponseTimeRegressions(responseTimes)
  # Write your code here
  count = 0
  sum = responseTimes[0]
  n = responseTimes.size
  
  (1...n).each do |i|
    # Calcula a média
    avg = sum.to_f / i

    # Conta se o elemnto for maior que a média
    count += 1 if responseTimes[i] > avg

    # Realiza a soma dos elementos
    sum += responseTimes[i]
  end
  count
end
