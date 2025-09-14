# LINK: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/min-tracking-stack/problem?isFullScreen=true

def processCouponStackOperations(operations)
  stack = []
  result = []

  operations.each do |operation|
    splited_operation = operation.split

    if splited_operation[0] == 'push'
      stack << splited_operation[1].to_i
    elsif splited_operation[0] == 'pop'
      stack.pop
    elsif splited_operation[0] == 'getMin'
      result << stack.min
    elsif splited_operation[0] == 'top'
      result << stack.last
    end
  end

  result
end



n = 10
# operations = ['push 2', 'push 0', 'push 3', 'push 0', 'getMin', 'pop', 'getMin', 'pop', 'top', 'getMin']
operations = ['getMin']


puts processCouponStackOperations(operations)