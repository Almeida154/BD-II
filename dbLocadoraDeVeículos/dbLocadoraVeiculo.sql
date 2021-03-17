-- A --

create database dbLocadoraVeiculo
go
use dbLocadoraVeiculo

	create table tbCliente(
		idCliente int primary key identity(1, 1)
		,nomeCliente varchar(35) not null
		,dataNascCliente date not null
		,cpfCliente varchar(14) not null
		,idadeCliente int not null
	)

	create table tbFabricante(
		idFabricante int primary key identity(1, 1)
		,nomeFabricante varchar(35) not null
		,cnpjFabricante varchar(14) not null
	)

	create table tbTipoCombustivel(
		idTipoCombustivel int primary key identity(1, 1)
		,descricaoTipoCombustivel varchar(10) not null

	)

	create table tbCategoriaVeiculo(
		idCategoriaVeiculo int primary key identity(1, 1)
		,descricaoCategoriaVeiculo varchar(30) not null
		,valorDiariaCategoria smallmoney not null
	)

	create table tbVeiculo(
		idVeiculo int primary key identity(1, 1)
		,modeloVeiculo varchar(20) not null
		,placaVeiculo varchar(7) not null
		,origemVeiculo varchar(2) not null
		,kmVeiculo int not null
		,idFabricante int foreign key references tbFabricante(idFabricante)
		,idTipoCombustivel int foreign key references tbTipoCombustivel(idTipoCombustivel)
		,idCategoriaVeiculo int foreign key references tbCategoriaVeiculo(idCategoriaVeiculo)
	)

	create table tbLocacao(
		idLocacao int primary key identity(1, 1)
		,dataLocacao date not null
		,dataDevolucao date not null
		,numeroDiariasLocacao int not null
		,valorTotalLocacao smallmoney not null
		,idCliente int foreign key references tbCliente(idCliente)
		,idVeiculo int foreign key references tbVeiculo(idVeiculo)
	)

	select * from tbCliente
	select * from tbFabricante
	select * from tbTipoCombustivel
	select * from tbCategoriaVeiculo
	select * from tbVeiculo
	select * from tbLocacao