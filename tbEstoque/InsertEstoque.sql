use bdEstoque2

	insert into tbCliente(nomeCliente, cpfCliente, emailCliente, sexoCliente, dataNascimentoCliente) 
		values('Tio Patinhas', 12345678909, 'tio@patinhas','M', '1956-12-24')
		,('Huguinho', 12345678909, 'sobrinho@Huguinho','M', '1976-11-24')
		,('Zézinho', 12345678909, 'sobrinho@Zézinho','M', '1976-10-24')
		,('Luizinho', 12345678909, 'sobrinho@Luizinho','M', '1976-09-24')
	select * from tbCliente

	insert into tbFabricante(nomeFabricante)
		values('Os Bananas')
		,('Saman Baia')
		,('Brinquedos so quebra')
		,('O lado escuro da lua')
	select * from tbFabricante

	insert into tbFornecedor(nomeFornecedor, contatoFornecedor) 
		values('Sokompropina','23456789')
		,('A quentinha','33445566')
		,('Venceuonte','44556677')
		,('Salmonela','55667788')
	select * from tbFornecedor

	insert into tbProduto(descricaoProduto, valorProduto, quantidadeProduto, codFabricante, codFornecedor) 
		values('Enlatado', 2.50, 4, 1, 4)
		,('Ensacado', 3.50, 4, 2, 3)
		,('Empacotado', 4.50, 4, 3, 2)
		,('Encaixotado', 5.50, 4, 4, 1)
	select * from tbProduto

	insert into tbVenda(dataVenda, valorTotalVenda, codCliente) 
		values('2014-02-01', 4500.0, 1)
		,('2014-02-03', 3400.0, 1)
		,('2014-02-10', 2100.0, 2)
		,('2014-02-15', 2700.0, 3)
		,('2014-03-17', 560.0, 3)
		,('2014-04-09', 1200.0, 4)
		,('2014-05-07', 3500.0, 4)
		,('2014-05-07', 3400.0, 1)
		,('2014-05-05', 4000.0, 2)
	select * from tbVenda

	insert into tbItensVenda(codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda) 
		values(1, 1, 200, 1500.0)
		,(1, 2, 300, 3000.0)
		,(2, 4, 120, 1400.0)
		,(2, 2, 200, 1000.0)
		,(2, 3, 130, 1000.0)
		,(3, 4, 200, 2100.0)
		,(4, 4, 120, 1000.0)
		,(4, 1, 450, 700.0)
		,(5, 2, 200, 560.0)
		,(6, 1, 200, 600.0)
		,(6, 4, 300, 600.0)
		,(8, 1, 300, 2500.0)
		,(8, 2, 200, 1000.0)
		,(9, 3, 250, 1700.0)
		,(9, 3, 200, 1700.0)
		,(9, 4, 1000, 4000.0)
	select * from tbItensVenda