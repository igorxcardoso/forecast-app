# Validate Properly Nested Brackets
# Given a string, check if all brackets ('()', '{}', '[]') are properly matched and nested. Return 1 if valid, otherwise return 0.

# Example
# Input
# code_snippet = if (a[0] > b[1]) { doSomething(); }

# Output
# 1

# Explanation
# All brackets are properly matched: '(' with ')', '[' with ']', and '{' with '}'. No mismatches or improper nesting.

# Input Format
# The function takes a single parameter, code_snippet, which is a STRING.

# Constraints
# 0 <= code_snippet.length <= 1000
# code_snippet consists of printable ASCII characters (character codes 32 to 126 inclusive)
# code_snippet may contain any combination of '(', ')', '{', '}', '[', ']', letters, digits, symbols, and whitespace
# code_snippet may be empty

# Output Format
# The function returns a BOOLEAN value, 1 for True and 0 for False.

require 'byebug'


def areBracketsProperlyMatched(code_snippet)
  
  # Caracteres para empilhar e verificar
  match_brackets = {
    ')': '(', 
    '}': '{',
    ']': '['
  }
  control_stack = []

  code_snippet.each_char do |ch|
    if match_brackets.values.include?(ch)
      control_stack.push ch
    elsif match_brackets.keys.map{|i| i.to_s}.include?(ch)
      # Valida se pilha está vazia ou se o elemento que está sendo desempilhado é diferente map no match_brackets
      return 0 if control_stack.empty? || control_stack.pop != match_brackets[ch.to_syb]
    end
  end
  
  control_stack.empty? ? 1 : 0
end


puts areBracketsProperlyMatched('[[()]]')