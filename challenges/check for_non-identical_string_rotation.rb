# LINK: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/check-non-identical-string-rotation/problem?isFullScreen=true

# Given two strings s1 and s2, return 1 if s2 is a rotation of s1 but not identical to s1, otherwise return 0.

def isNonTrivialRotation(s1, s2)
  # Verifica se as strings são iguais (não permitido s1 e s2 idênticas)
  return false if s1 == s2

  # Para ser uma rotação precisa ter tamanho iguais
  return false if s1.length != s2.length

  # Se s2 é uma rotação de s1, então s2 sempre estará contida em s1 + s1.
  (s1 + s1).include?(s2)
end