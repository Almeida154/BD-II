use dbConfeitaria
	
	----------- (A) -----------

	create procedure spInsereCategoria @nomeCategoria varchar(20) as
	begin
		if exists(select nomeCategoriaProduto from tbCategoriaProduto where nomeCategoriaProduto like @nomeCategoria)
			begin print('Categoria já cadastrada!') end
		else
			begin
				insert into tbCategoriaProduto(nomeCategoriaProduto)
				values(@nomeCategoria)
			end
	end

	exec spInsereCategoria 'Bolo Festa'
	exec spInsereCategoria 'Bolo Simples'
	exec spInsereCategoria 'Torta'
	exec spInsereCategoria 'Salgado'
	select codCategoriaProduto as 'Cod', nomeCategoriaProduto as 'Categoria' from tbCategoriaProduto


	----------- (B) -----------

	create procedure spInsereProduto @nomeProduto varchar(20), @precoKilo float, @codCategoriaProduto int as
	begin
		if exists(select nomeProduto from tbProduto where nomeProduto like @nomeProduto)
			begin print('Produto já cadastrado!') end
		else
			begin
				insert into tbProduto(nomeProduto, precoKiloProduto, codCategoriaProduto)
				values(@nomeProduto, @precoKilo, @codCategoriaProduto)
			end
	end

	exec spInsereProduto 'Bolo Floresta Negra', 42, 1
	exec spInsereProduto 'Bolo Prestígio', 43, 1
	exec spInsereProduto 'Bolo Nutella', 44, 1
	exec spInsereProduto 'Bolo Formigueiro', 17, 2
	exec spInsereProduto 'Bolo de cenoura', 19, 2
	exec spInsereProduto 'Torta de palmito', 45, 3
	exec spInsereProduto 'Torta de frango e catupiry', 47, 3
	exec spInsereProduto 'Torta de escarola', 44, 3
	exec spInsereProduto 'Coxinha frango', 25, 4
	exec spInsereProduto 'Esfiha carne', 27, 4
	exec spInsereProduto 'Folhado queijo', 31, 4
	exec spInsereProduto 'Risoles misto', 29, 4
	select codProduto as 'Cod', nomeProduto as 'Produto', precoKiloProduto as 'Preço/Kg', codCategoriaProduto as 'Cod da Categoria' from tbProduto


	----------- (C) -----------

	create procedure spCadastraCliente @nomeCliente varchar(30), @dataNasCliente date, @cpfCliente varchar(14), @sexoCliente char, @ruaCliente varchar(25),
		@numCasaCliente int, @cepCliente varchar(9), @bairroCliente varchar(20), @cidadeCliente varchar(20), @estadoCliente varchar(2) as
	begin
		if exists(select cpfCliente from tbCliente where cpfCliente like @cpfCliente)
			begin 
				print('Cliente do cpf ' + @cpfCliente + ' já cadastrado!') 
				select nomeCliente as 'Nome', cpfCliente as 'Cpf' from tbCliente
			end
		else if(@bairroCliente = 'Itaquera' or @bairroCliente = 'Guaianases')
			begin
				insert into tbCliente(nomeCliente, dataNascimentoCliente, cpfCliente, sexoCliente, ruaCliente, numCasaCliente, cepCliente, bairroCliente, 
					cidadeCliente, estadoCliente)
				values(@nomeCliente, @dataNasCliente, @cpfCliente, @sexoCliente, @ruaCliente, @numCasaCliente, @cepCliente, @bairroCliente, @cidadeCliente, @estadoCliente)
			end
		else
			begin print('Não foi possível cadastrar o cliente de cpf ' + @cpfCliente + ' pois o bairro ' + @bairroCliente + ' não é atendido pela confeitaria.') end
	end

	exec spCadastraCliente 'Samira Fatah', '1990/05/05', '123.456.789-01', 'F', 'Rua Aguapeí', 1000, '8090000', 'Guaianases', 'São Paulo', 'SP'
	exec spCadastraCliente 'Celia Nogueira', '1992/06/06', '234.567.890-12', 'F', 'Rua Andes', 234, '8456090', 'Guaianases', 'São Paulo', 'SP'
	exec spCadastraCliente 'Paulo Cesar Siqueira', '1984/04/04', '345.678.901-23', 'M', 'Rua Castelo do Piauí', 232, '8109000', 'Itaquera', 'São Paulo', 'SP'
	exec spCadastraCliente 'Rodrigo Favaroni', '1991/04/09', '456.789.012-34', 'M', 'Rua Sansão Castelo Branco', 10, '8431090', 'Guaianases', 'São Paulo', 'SP'
	exec spCadastraCliente 'Flávia Regina Brito', '1992/04/22', '567.890.123-45', 'F', 'Rua Mariano Moro', 300, '8200123', 'Itaquera', 'São Paulo', 'SP'
	select codCliente as 'Cod', nomeCliente as 'Nome', dataNascimentoCliente as 'Nascimento', cpfCliente as 'Cpf', sexoCliente as 'Sexo', ruaCliente as 'Rua',
	numCasaCliente as 'Num. Res.', cepCliente as 'Cep', bairroCliente as 'Bairro', cidadeCliente as 'Cidade', estadoCliente as 'Uf' from tbCliente


	----------- (D) -----------

	create procedure spEncomenda @cpfCliente varchar(14), @dataEntrega date, @valorTotal smallmoney as
	begin
		if exists(select cpfCliente from tbCliente where cpfCliente like @cpfCliente)
			begin
				if(@dataEntrega > GETDATE() - 1)
					begin
						declare @codEncomenda int
						declare @codCliente int
						declare @nomeCliente varchar(30)
						select @codCliente = codCliente from tbCliente where cpfCliente like @cpfCliente
						select @nomeCliente = nomeCliente from tbCliente where cpfCliente like @cpfCliente
						insert into tbEncomenda(dataEncomenda, codCliente, valorTotalEncomenda, dataEntregaEncomenda)
						values(GETDATE(), @codCliente, @valorTotal, @dataEntrega)
						select @codEncomenda = max(codEncomenda) from tbEncomenda
						print('Encomenda de código ' + cast(@codEncomenda as varchar(3)) + ' para o cliente ' + @nomeCliente + ' efetuada com sucesso!')
					end
				else
					begin print('Data inválida. Não é possível efetuar uma entrega numa data anterior à data atual!') end
			end
		else
			begin print('Cliente de cpf ' + @cpfCliente + ' não cadastrado!') end
	end

	exec spEncomenda '123.456.789-01', '2020/08/26', 450
	exec spEncomenda '234.567.890-12', '2020/10/15', 200
	exec spEncomenda '345.678.901-23', '2020/12/10', 150
	exec spEncomenda '123.456.789-01', '2020/10/12', 250
	exec spEncomenda '456.789.012-34', '2020/10/12', 150
	select codEncomenda as 'Cod', dataEncomenda as 'Data da Encomenda', codCliente as 'Cod do Cliente', valorTotalEncomenda as 'Valor Total', dataEntregaEncomenda as
	'Data de Entrega' from tbEncomenda


	----------- (E) -----------

	create procedure spInsereItensEncomenda as
	begin
		insert into tbItensEncomenda(codEncomenda, codProduto, quantidadeKilos, subTotal)
		values(1, 1, 2.5, 105)
		,(1, 10, 2.6, 70)
		,(1, 9, 6, 150)
		,(1, 12, 4.3, 125)
		,(2, 9, 8, 200)
		,(3, 11, 3.2, 100)
		,(3, 9, 2, 50)
		,(4, 2, 3.5, 150)
		,(4, 3, 2.2, 100)
		,(5, 6, 3.4, 140)
	end

	exec spInsereItensEncomenda
	select codItensEncomenda as 'Cod', codEncomenda as 'Cod da Encomenda', codProduto as 'Cod do Produto', quantidadeKilos as 'KG', subTotal as 'Subtotal' 
	from tbItensEncomenda


	----------- (F) -----------

	create procedure spUpdatePrices as
	begin
		-- 1 --
		update tbProduto set precoKiloProduto += (precoKiloProduto * 10) / 100 where codCategoriaProduto = (select codCategoriaProduto from tbCategoriaProduto
			where nomeCategoriaProduto like 'Bolo Festa')
		-- 2 --
		update tbProduto set precoKiloProduto -= (precoKiloProduto * 20) / 100 where codCategoriaProduto = (select codCategoriaProduto from tbCategoriaProduto
			where nomeCategoriaProduto like 'Bolo Simples')
		-- 3 --
		update tbProduto set precoKiloProduto += (precoKiloProduto * 25) / 100 where codCategoriaProduto = (select codCategoriaProduto from tbCategoriaProduto
			where nomeCategoriaProduto like 'Torta')
		-- 4 --
		update tbProduto set precoKiloProduto += (precoKiloProduto * 20) / 100 where codCategoriaProduto = (select codCategoriaProduto from tbCategoriaProduto
			where nomeCategoriaProduto like 'Salgado') and nomeProduto != 'Esfiha carne'
	end

	exec spUpdatePrices
	select codProduto as 'Cod', nomeProduto as 'Produto', precoKiloProduto as 'Preço/Kg', codCategoriaProduto as 'Cod da Categoria' from tbProduto


	----------- (G) -----------

	create procedure spRemoveCliente @cpfCliente varchar(14) as
	begin
		if exists(select cpfCliente from tbCliente where cpfCliente like @cpfCliente)
			begin
				declare @nomeCliente varchar(30)
				select @nomeCliente = nomeCliente from tbCliente where cpfCliente like @cpfCliente
				if not exists(select cpfCliente from tbEncomenda inner join tbCliente on tbEncomenda.codCliente = tbCliente.codCliente
					where cpfCliente like @cpfCliente)
					begin
						delete from tbCliente where cpfCliente like @cpfCliente
						print('Cliente ' + @nomeCliente + ' removido com sucesso!')
					end
				else 
					begin print('Impossível remover. O cliente ' + @nomeCliente + ' possui encomendas pendentes') end
			end
		else
			begin print('Cliente não encontrado!') end
	end

	exec spRemoveCliente '567.890.123-45'
	select codCliente as 'Cod', nomeCliente as 'Nome', dataNascimentoCliente as 'Nascimento', cpfCliente as 'Cpf', sexoCliente as 'Sexo', ruaCliente as 'Rua',
	numCasaCliente as 'Num. Res.', cepCliente as 'Cep', bairroCliente as 'Bairro', cidadeCliente as 'Cidade', estadoCliente as 'Uf' from tbCliente


	----------- (H) -----------

	create procedure spRemoveItemEncomenda @codEncomenda int, @codProduto int as
	begin
		declare @dataEntrega date
		select @dataEntrega = dataEntregaEncomenda from tbEncomenda where codEncomenda = @codEncomenda
		if(@dataEntrega > GETDATE())
			begin
				if exists(select codProduto from tbItensEncomenda where codProduto = @codProduto and codEncomenda = @codEncomenda)
					begin
						declare @subtotal smallmoney
						select @subtotal = subTotal from tbItensEncomenda where codProduto = @codProduto
						delete from tbItensEncomenda where codEncomenda = @codEncomenda and codProduto = @codProduto
						update tbEncomenda set valorTotalEncomenda -= @subtotal where codEncomenda = @codEncomenda
					end
				else begin print('Item não existente!') end
			end
		else begin print('Impossível remover, a data de entrega é hoje!') end
	end

	exec spRemoveItemEncomenda 3, 9
	select codEncomenda as 'Cod', dataEncomenda as 'Data da Encomenda', codCliente as 'Cod do Cliente', valorTotalEncomenda as 'Valor Total', dataEntregaEncomenda as
	'Data de Entrega' from tbEncomenda
	select codItensEncomenda as 'Cod', codEncomenda as 'Cod da Encomenda', codProduto as 'Cod do Produto', quantidadeKilos as 'KG', 
	subTotal as 'Subtotal' from tbItensEncomenda