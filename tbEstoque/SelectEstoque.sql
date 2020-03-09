use bdEstoque2

	--A--
	select descricaoProduto as 'Descrição', nomeFabricante as 'Fabricante' from tbProduto
		inner join tbFabricante
			on tbFabricante.codFabricante = tbProduto.codFabricante

	--B--
	select descricaoProduto as 'Descrição', nomeFornecedor as 'Fornecedor' from tbProduto
		inner join tbFornecedor
			on tbFornecedor.codFornecedor = tbProduto.codFornecedor

	--C--
	select sum(quantidadeProduto) as 'Quantidade de Produtos', nomeFabricante as 'Fabricante' from tbProduto
		inner join tbFabricante
			on tbFabricante.codFabricante = tbProduto.codFabricante
				group by nomeFabricante

	--D--
	select sum(valorTotalVenda) as 'Valor Total de Compras', nomeCliente as 'Nome do Cliente' from tbVenda
		inner join tbCliente
			on tbCliente.codCliente = tbVenda.codCliente
				group by nomeCliente

	--E--
	select avg(valorProduto) as 'Média dos Preços', nomeFornecedor as 'Fornecedor' from tbProduto
		inner join tbFornecedor
			on tbFornecedor.codFornecedor = tbProduto.codFornecedor
				group by nomeFornecedor

	--F--
	select sum(valorTotalVenda) as 'Valor Total de Compras', nomeCliente as 'Nome do Cliente' from tbVenda
		inner join tbCliente
			on tbCliente.codCliente = tbVenda.codCliente
				group by nomeCliente
					order by [Nome do Cliente] asc

	--G--
	select sum(valorProduto) as 'Soma dos Preços', nomeFabricante as 'Fabricante' from tbProduto
		inner join tbFabricante
			on tbFabricante.codFabricante = tbProduto.codFabricante
				group by nomeFabricante

	--H--
	select avg(valorProduto) as 'Média dos Preços', nomeFornecedor as 'Fornecedor' from tbProduto
		inner join tbFornecedor
			on tbFornecedor.codFornecedor = tbProduto.codFornecedor
				group by nomeFornecedor

	--I--
	select sum(valorTotalVenda) as 'Valor Total de Vendas', descricaoProduto from tbVenda
		inner join tbItensVenda
			on tbItensVenda.codVenda = tbItensVenda.codProduto
		inner join tbProduto
			on tbProduto.codProduto = tbVenda.codVenda
				group by descricaoProduto

	--J--
	select sum(valorTotalVenda) as 'Soma das Vendas', nomeCliente as 'Nome do Cliente' from tbVenda
		inner join tbCliente
			on tbCliente.codCliente = tbVenda.codCliente
				where datepart(year, dataVenda) = 2014 and datepart(month, dataNascimentoCliente) = 02
					group by nomeCliente