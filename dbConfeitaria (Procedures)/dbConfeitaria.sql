create database dbConfeitaria
go
use dbConfeitaria 

	create table tbCliente(
		codCliente int primary key identity(1, 1)
		,nomeCliente varchar(30) not null
		,dataNascimentoCliente date not null
		,ruaCliente varchar(25) not null
		,numCasaCliente int not null
		,cepCliente varchar(9) not null
		,bairroCliente varchar(20) not null
		,cidadeCliente varchar(20) not null
		,estadoCliente varchar(20) not null
		,cpfCliente varchar(14) not null
		,sexoCliente char not null
	)

	create table tbEncomenda(
		codEncomenda int primary key identity(1, 1)
		,codCliente int foreign key references tbCliente(codCliente)
		,dataEncomenda date not null
		,valorTotalEncomenda smallmoney not null
		,dataEntregaEncomenda date not null
	)

	create table tbCategoriaProduto(
		codCategoriaProduto int primary key identity(1, 1)
		,nomeCategoriaProduto varchar(20) not null
	)

	create table tbProduto(
		codProduto int primary key identity(1, 1)
		,codCategoriaProduto int foreign key references tbCategoriaProduto(codCategoriaProduto)
		,nomeProduto varchar(20) not null
		,precoKiloProduto smallmoney not null	
	)

	create table tbItensEncomenda(
		codItensEncomenda int primary key identity(1, 1)
		,codEncomenda int foreign key references tbEncomenda(codEncomenda)
		,codProduto int foreign key references tbProduto(codProduto)
		,quantidadeKilos float not null
		,subTotal smallmoney not null
	)