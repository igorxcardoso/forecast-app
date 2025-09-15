# LINK: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/find-smallest-missing-positive-integer/problem?isFullScreen=true

def first_missing_positive(nums)
  n = nums.length
  i = 0

  # Rearranjo in-place
  while i < n
    correct_index = nums[i] - 1

    # Precisa ser positivo
    # Ser menor ou igual ao tamaanho do array
    # Ser difente do item na posição

    if nums[i] > 0 && nums[i] <= n && nums[i] != nums[correct_index]
      # Se nums[i] estiver no intervalor, for menor que o tmanho do array, e for diferente do elemnto na posição correta
      # nums[i] != nums[correct_index]: Se nums[i] já é igual ao valor no lugar correto, trocar seria inútil (trocar valores iguais) e não convergiria.

      # Troco os elemntos de posição (swap)
      temp = nums[i]
      nums[i] = nums[correct_index]
      nums[correct_index] = temp

      # num[i], num[correct_index] = num[correct_index], num[i]

    else
      # Se nums[i] estiver fora do internavor (for negativo) incremento o index i
      i += 1
    end
  end

  puts nums

  # Busca do menor positivo ausente
  (0...n).each do |i|
    return i + 1 if nums[i] != i + 1
  end

  # Caso todos estejam corretos
  n + 1
end


test = first_missing_positive([10, 2, -1, 1])
puts "\n\n"
puts test