require_relative 'produto'
require_relative 'cliente'
require_relative 'carrinho'



# Criando produtos
p1 = Produto.new("Notebook", 3500.0, 5)
p2 = Produto.new("Mouse", 150.0, 10)
p3 = Produto.new("Teclado", 300.0, 2)


# Criando cliente
cliente = Cliente.new("Igor")


# Adicionar produtos ao carrinho
cliente.carrinho.adicionar_produto(p1, 2)
cliente.carrinho.adicionar_produto(p2, 1)
cliente.carrinho.adicionar_produto(p3, 3)  # estoque insuficiente

# Mostrar carrinho
cliente.carrinho.mostrar_itens

# Remover produto
cliente.carrinho.remover_produto(p1, 1)
cliente.carrinho.mostrar_itens

# Finalizar compra
cliente.finalizar_compra