create database bdHotel
go
use bdHotel
	
	create table tbCliente(
	codCliente int primary key identity(1,1)
	,nomeCliente varchar(30) not null
	,dtNascCliente date not null
	,cpfCliente char(15) not null
	)

	create table tbReserva(
	codReserva int primary key identity(1,1)
	,dataReserva date not null
	,horaReserva time not null
	,codCliente int foreign key references tbCliente(codCliente)
	,dataPrevistaCheckin date not null
	,dataPrevistaCheckout date not null
	,numHospedes int not null
	,numAptos int not null
	,valorReserva smallmoney not null
	,valorEntrada smallmoney not null
	)

	create table tbTipoApto(
	codTipoApto int primary key identity(1,1)
	,descricaoTipo varchar(50) not null
	)

	create table tbApto(
	codApto int primary key identity(1,1)
	,descricaoApto varchar(50) not null
	,andarApto int not null
	,codTipoApto int foreign key references tbTipoApto(codTipoApto)
	)

	create table tbReservaApto(
	codReservaApto int primary key identity(1,1)
	,codReserva int foreign key references tbReserva(codReserva)
	,codTipoApto int foreign key references tbTipoApto(codTipoApto)
	)

	create table tbHospedagem(
	codHospedagem int primary key identity(1,1)
	,codReserva int foreign key references tbReserva(codReserva)
	,codApto int foreign key references tbApto(codApto)
	)

	create table tbHospede(
	codHospede int primary key identity(1,1)
	,nomeHospede varchar(30) not null
	,dtNascHospede date not null
	,emailHospede varchar(30) not null
	)

	create table tbCheckin(
	codCheckin int primary key identity(1,1)
	,dataHoraCheckin datetime not null
	,dataHoraCheckout datetime not null
	,codHospede int foreign key references tbHospede(codHospede)
	,codHospedagem int foreign key references tbHospedagem(codHospedagem)
	)

	create table tbProduto(
	codProduto int primary key identity(1,1)
	,descricaoProduto varchar(20) not null
	,valorProduto smallmoney not null
	,quantidadeProduto int not null
	)

	create table tbConta(
	codConta int primary key identity(1,1)
	,dataAberturaConta date not null
	,dataFechamentoConta date not null
	,codHospedagem int foreign key references tbHospedagem(codHospedagem)
	,valorTotalConta money not null
	)

	create table tbContaProduto(
	codContaProduto int primary key identity(1,1)
	,codConta int foreign key references tbConta(codConta)
	,codProduto int foreign key references tbProduto(codProduto)
	,quantidade int not null
	,subTotalContaProduto smallmoney not null
	)

	create table tbServico(
	codServico int primary key identity(1,1)
	,descricaoServico varchar(30) not null
	,valorServico smallmoney not null 
	)

	create table tbContaServico(
	codContaServico int primary key identity(1,1)
	,codConta int foreign key references tbConta(codConta)
	,codServico int foreign key references tbServico(codServico)
	,quantidade int not null
	,subTotalContaServico smallmoney not null
	)

	create table tbFormaPagto(
	codFormaPagto int primary key identity(1,1)
	,descricaoFormaPagto varchar(30)
	)

	create table tbParcela(
	codParcela int primary key identity(1,1)
	,codFormaPagto int foreign key references tbParcela(codParcela)
	,codConta int foreign key references tbConta(codConta)
	,valorParcela money not null
	)

