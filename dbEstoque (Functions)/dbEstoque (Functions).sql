use dbEstoque

	
	-- 1 --

	create function fcReturnSaleDay(@codVenda smallint) returns varchar(50) as
	begin
		declare @groupData varchar(50)
		declare @weekDay varchar(20)
		declare @date date set @date = (select dataVenda from tbVenda where codVenda = @codVenda)
		declare @day int set @day = DATEPART(dw, @date)
		set @weekDay = (
				case @day
					when 1 then 'Domingo'
					when 2 then 'Segunda-Feira'
					when 3 then 'Terça-Feira'
					when 4 then 'Quarta-Feira'
					when 5 then 'Quinta-Feira'
					when 6 then 'Sexta-Feira'
					when 7 then 'Sábado'
					else 'Venda não encontrada!'
				end
			)
		set @groupData = @weekDay + ' | ' + (select CONVERT(varchar, codVenda) + ' | R$' + CONVERT(varchar, valorTotalVenda) from tbVenda
			where codVenda = @codVenda) + ' | ' + CONVERT(varchar, @date, 103)
		return @groupData
	end

	select Sale = dbo.fcReturnSaleDay(codVenda) from tbVenda


	-- 2 --

	create function fcReturnTot(@codCliente smallint) returns int as
	begin												
		declare @qnt int set @qnt = 
			(select COUNT(tbVenda.codCliente) from tbVenda
				inner join tbCliente on tbCliente.codCliente = tbVenda.codCliente
					where tbVenda.codCliente = @codCliente
						group by tbVenda.codCliente, tbCliente.nomeCliente
			)

		return @qnt
	end

	create function fcReturnTot2(@codCliente smallint) returns varchar(40) as
	begin
		declare @i int
		declare @name varchar(30) set @name = (select nomeCliente from tbCliente where codCliente = @codCliente)
		select @i = COUNT(codCliente) from tbVenda where codCliente = @codCliente
		return (@name + ' comprou ' + CONVERT(varchar, @i) + ' vezes')
	end


	select nomeCliente, Tot = dbo.fcReturnTot(tbVenda.codCliente) from tbVenda -- Todos os clientes
		inner join tbCliente on tbCliente.codCliente = tbVenda.codCliente
			group by tbCliente.nomeCliente, tbVenda.codCliente

	select Tot = dbo.fcReturnTot2(1)  -- Cliente específico


	-- 3 --

	create function fcTotSalesInTheMonth(@codSalesman smallint, @month smallint) returns varchar(30) as
	begin

		declare @providerName varchar(20)
		declare @contactName varchar(20)
		declare @tot money

		select @providerName = nomeFornecedor, @contactName = contatoFornecedor, @tot = sum(subTotalItensVenda) from tbFornecedor
				inner join tbProduto on tbFornecedor.codFornecedor = tbProduto.codFornecedor
					inner join tbItensVenda on tbProduto.codProduto = tbItensVenda.codProduto
						inner join tbVenda on tbItensVenda.codVenda = tbVenda.codVenda
							where DATEPART(MONTH, dataVenda) = @month and tbProduto.codFornecedor = @codSalesman
								group by nomeFornecedor, contatoFornecedor
			
		return 'R$' + CONVERT(varchar, @tot) + ' | (' + @providerName + ') ' + @contactName

	end

	select perMonth = dbo.fcTotSalesInTheMonth(codFornecedor, 5) from tbFornecedor -- Todos os fornecedores
	select perMonth = dbo.fcTotSalesInTheMonth(1, 5) -- Fornecedor específico


	-- 4 --

	alter function fcValidateCpf(@cpf varchar(11)) returns varchar(12) as
	begin

		declare @i int, @sum int, @dig1 int, @dig2 int, @cpfTemp varchar(11), 
		@sameDig char(1), @res varchar(12)

		set @i = 1
		set @cpfTemp = SUBSTRING(@cpf, 1, 1)
		set @sameDig = 'T'
		set @res = 'Cpf inválido'

		while(@i <= 11)
			begin
				if(SUBSTRING(@cpf, @i, 1)) <> @cpfTemp begin set @sameDig = 'F' end
				set @i = @i + 1
			end

		if(@sameDig = 'F')
			begin
				set @sum = 0
				set @i = 1
				while(@i <= 9)
					begin
						set @sum = @sum + CONVERT(int, SUBSTRING(@cpf, @i, 1)) * (11 - @i)
						set @i = @i + 1
					end
				set @dig1 = 11 - (@sum % 11)
				if(@dig1 > 9) begin set @dig1 = 0 end

				set @sum = 0
				set @i = 1
				while(@i <= 9)
					begin
						set @sum = @sum + CONVERT(int, SUBSTRING(@cpf, @i, 1)) * (12 - @i)
						set @i = @i + 1
					end
				set @dig2 = 11 - (@sum % 11)
				if(@dig2 > 9) begin set @dig2 = 0 end

				if((@dig1 = SUBSTRING(@cpf, LEN(@cpf) - 1, 1)) and (@dig2 = SUBSTRING(@cpf, LEN(@cpf), 1))) begin set @res = 'Cpf válido' end
				else begin set @res = 'Cpf inválido' end
			end
		return @res
	end

	select nomeCliente as 'Client', ValidateCpf = dbo.fcValidateCpf(cpfCliente) from tbCliente -- Todos os clientes
	select ValidateCpf = dbo.fcValidateCpf('53509123808') -- Teste avulso