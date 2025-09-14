# LINK: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/custom-fibonacci-sequence/problem


def getAutoSaveInterval(n)
  return 1 if n == 0
  return 2 if n == 1

  # Para n >= 2

  a, b = 1, 2
  (2..n).each do
    # temp = a
    # a = b
    # b = temp + b

    a, b = b, a + b
  end
  
  b
end

# Recursiva
def custom_fibonacci(n)
  return 1 if n == 0
  return 2 if n == 1
  custom_fibonacci(n - 1) + custom_fibonacci(n - 2)
end


puts getAutoSaveInterval(10)
puts custom_fibonacci(10)