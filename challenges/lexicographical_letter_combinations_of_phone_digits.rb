def minTasksToCancelForNoConflict(digits)
  return [] if digits.empty?

  # Construindo o mapeamento do teclado
  # alphabet = ('a'..'z').to_a
  # alphabet_map = {}
  # init = 0
  # final = 2

  # digits.each_char do |ch|
  #   if ch != '0' && ch != '1'
  #     alphabet_map[ch] = alphabet[init..final]
  #     init += 3
  #     final += 3
  #     # Reinicia se passar do 'z'
  #     if final >= 26
  #       init = 0
  #       final = 2
  #     end
  #   else
  #     alphabet_map[ch] = [ch]
  #   end
  # end

  phone_map = {
    '2' => %w[a b c],
    '3' => %w[d e f],
    '4' => %w[g h i],
    '5' => %w[j k l],
    '6' => %w[m n o],
    '7' => %w[p q r s],
    '8' => %w[t u v],
    '9' => %w[w x y z],
    '0' => ['0'],
    '1' => ['1']
  }

  # Inicia com um array contendo uma string vazia
  combinations = ['']

  # Itera sobre cada dígito e combina com as letras correspondentes
  digits.each_char do |digit|
    letters = phone_map[digit]
    # product combina cada combinação existente com cada letra do dígito atual
    combinations = combinations.product(letters).map(&:join)
  end

  combinations
end



puts minTasksToCancelForNoConflict('171717')