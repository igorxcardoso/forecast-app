class Produto
  attr_reader :nome, :preco

  def initialize(nome, preco, estoque=5)
    @nome = nome
    @preco = preco
    @estoque = estoque
  end

  def reduzir_estoque(qtd)
    if qtd <= @estoque
      @estoque -= qtd
      true
    else
      false
    end
  end

  def adicionar_estoque(qtd)
    @estoque += qtd if qtd > 0
  end

  def to_s
    "#{@nome} - R$#{'%.2f' % @preco} (#{@estoque} disponíveis)"
  end
end
