use bdEstoque
	
	--1--

						-- Criei! --

	--2--
	select nomeFornecedor as 'Nome do Fornecedor', descricaoProduto as 'Descrição' from tbFornecedor
		inner join tbProduto on tbProduto.codFornecedor = tbFornecedor.codFornecedor
			order by [Nome do Fornecedor]

	--3--	select nomeFornecedor as 'Nome do Fornecedor', descricaoProduto as 'Descrição' from tbFornecedor
		left join tbProduto on tbProduto.codFornecedor = tbFornecedor.codFornecedor
			order by [Nome do Fornecedor]	select descricaoProduto as 'Descrição', nomeFornecedor as 'Nome do Fornecedor' from tbProduto
		right join tbFornecedor on tbProduto.codFornecedor = tbFornecedor.codFornecedor
			order by [Nome do Fornecedor]	--4--						-- Criei! --	--5--	select descricaoProduto as 'Descrição', nomeFornecedor as 'Nome do Fornecedor' from tbProduto
		full join tbFornecedor on tbProduto.codFornecedor = tbFornecedor.codFornecedor
			order by [Descrição]

	--6--
	select descricaoProduto as 'Descrição', nomeFornecedor as 'Nome do Fornecedor' from tbProduto
		cross join tbFornecedor
			order by [Descrição]

	-- R. Foi retornado 78 registros. Isso porque o CROSS multiplicou: tbFornecedor (6) * (13) tbProduto :) --