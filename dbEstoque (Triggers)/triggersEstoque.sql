use bdEstoque

	-- 1 --

	create trigger tgAtualizaEstoque on tbItensVenda after insert as
		begin
			declare @codProduto int, @qtdProduto int
			set @codProduto = (select codProduto from inserted)
			set @qtdProduto = (select quantidadeItensVenda from inserted)
			update tbProduto set quantidadeProduto -= @qtdProduto where codProduto = @codProduto
		end

	select * from tbProduto
	select * from tbItensVenda
	insert into tbItensVenda(codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda) values(1, 10, 10, 65.00)


	-- 2 --

	create trigger tgEntradaProduto on tbEntradaProduto after insert as
		begin
			declare @codProduto int, @qtdProduto int
			set @codProduto = (select codProduto from inserted)
			set @qtdProduto = (select quantidadeEntradaProduto from inserted)
			update tbProduto set quantidadeProduto += @qtdProduto where codProduto = @codProduto
		end

	select * from tbProduto
	insert into tbEntradaProduto(codProduto, dataEntradaProduto, quantidadeEntradaProduto) values(8, GETDATE(), 30)


	-- 3 --

	create trigger tgSaidaProduto on tbItensVenda after insert as
		begin
			declare @codProduto int, @qtdProduto int
			set @codProduto = (select codProduto from inserted)
			set @qtdProduto = (select quantidadeItensVenda from inserted)
			insert into tbSaidaProduto(codProduto, dataSaidaProduto, quantidadeSaidaProduto) values(@codProduto, GETDATE(), @qtdProduto)
		end

	select * from tbProduto
	select * from tbItensVenda
	select * from tbSaidaProduto
	insert into tbItensVenda(codVenda, codProduto, quantidadeItensVenda, subTotalItensVenda) values(1, 1, 10, 57.60)
