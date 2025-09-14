require_relative 'carrinho'

class Cliente
  attr_reader :nome, :carrinho

  def initialize(nome)
    @nome = nome
    @carrinho = Carrinho.new
  end

  def finalizar_compra
    puts "#{@nome} finalizou a compra."
    @carrinho.mostrar_itens
  end
end