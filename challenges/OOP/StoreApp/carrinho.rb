class Carrinho
  def initialize
    @itens = []
  end

  def adicionar_produto(produto, quantidade=1)
    if quantidade >= 1
      if produto.reduzir_estoque(quantidade)
        item = @itens.find{ |i| i[:produto] == produto }
        if item
          item[:quantidade] += quantidade
        else
          @itens << { produto: produto, quantidade: quantidade }
        end
        puts "#{quantidade} x #{produto.nome} adicionado(s) ao carrinho."
      else
        puts "Estoque insuficiente para #{produto.nome}."
      end
    else
      puts "Quantidade inválida!"
    end
  end

  def remover_produto(produto, quantidade=1)
    item = @itens.find { |i| i[:produto] == produto }
    return puts "#{produto.nome} não está no carrinho." unless item

    if quantidade >= item[:quantidade]
      @itens.delete(item)
      produto.adicionar_estoque(item[:quantidade])
      puts "#{produto.nome} removido do carrinho."
    else
      item[:quantidade] -= quantidade
      produto.adicionar_estoque(quantidade)
      puts "#{quantidade} x #{produto.nome} removido(s) do carrinho."
    end
  end

  def total
    @itens.inject(0) { |sum, item| sum + (item[:produto].preco * item[:quantidade]) }
  end

  def mostrar_itens
    puts "Itens no carrinho:"
    @itens.each do |item|
      puts "#{item[:quantidade]} x #{item[:produto].nome} - R$#{'%.2f' % (item[:produto].preco * item[:quantidade])}"
    end
    puts "Total: R$#{'%.2f' % total}\n\n"
  end
end