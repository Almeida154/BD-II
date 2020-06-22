use bdEstoque

	-- 1 --
	select codProduto as 'Código', descricaoProduto as 'Nome', nomeFabricante as 'Fabricante' from tbProduto
		full join tbFabricante on tbFabricante.codFabricante = tbProduto.codFabricante
			where valorProduto in (select max(valorProduto) from tbProduto)

	-- 2 --
	select descricaoProduto as 'Nome', nomeFabricante as 'Fabricante' from tbProduto
		full join tbFabricante on tbFabricante.codFabricante = tbProduto.codFabricante
			where valorProduto in (select valorProduto from tbProduto 
				where valorProduto > (select avg(valorProduto) from tbProduto)) 

	-- 3 --
	select codVenda as 'Código da Venda', nomeCliente as 'Nome' from tbCliente
		inner join tbVenda on tbVenda.codCliente = tbCliente.codCliente
			where valorTotalVenda in (select valorTotalVenda from tbVenda
				where valorTotalVenda > (select avg(valorTotalVenda) from tbVenda))

	-- 4 --
	select descricaoProduto as 'Nome', valorProduto as 'Preço' from tbProduto
		where valorProduto in (select max(valorProduto) from tbProduto)

	-- 5 --
	select descricaoProduto as 'Nome', valorProduto as 'Preço' from tbProduto
		where valorProduto = (select min(valorProduto) from tbProduto)
