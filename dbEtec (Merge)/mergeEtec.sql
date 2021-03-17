create database dbEtec
go
use dbEtec

	-- Database

	create table tb2MtecA(
		rmAluno int primary key
		,nomeAluno varchar(30) not null
		,statusAluno varchar(10) not null
	)

	create table tb2MtecB(
		rmAluno int primary key
		,nomeAluno varchar(30) not null
		,statusAluno varchar(10) not null
	)

	create table tb3Mtec(
		rmAluno int primary key
		,nomeAluno varchar(30) not null
	)

	-- Insert

	insert into tb2MtecA(rmAluno, nomeAluno, statusAluno) values
		(19118, 'David Almeida Santos', 'APROVADO')
		,(19123, 'Mariana Santos Fernandes', 'APROVADO')
		,(19321, 'Kayan Lucas Lopes de Rocha', 'APROVADO')
		,(19852, 'Vitória Gonçalves Passos', 'APROVADO')
		,(19258, 'Deivid Bryan', 'APROVADO')
		,(19456, 'Italo Bruno', 'APROVADO')
		,(19654, 'Isabela Saori', 'APROVADO')
		,(19147, 'Camylly Ferreira Lima', 'REPROVADO') -- Reprovei por vingança
		,(19148, 'Kauê Loviz de Oliveira', 'REPROVADO') -- Reprovei por vingança
		,(19159, 'Samuel Guerra', 'REPROVADO') -- Reprovei por vingança

	select * from tb2MtecA

	insert into tb2MtecB(rmAluno, nomeAluno, statusAluno) values
		(19951, 'Victor Araujo', 'APROVADO')
		,(19145, 'Rafaela', 'APROVADO')
		,(19365, 'Matheus Salermo', 'APROVADO')
		,(19854, 'Ícaro', 'APROVADO')
		,(19856, 'Mel Garcia', 'APROVADO')
		,(19984, 'Juan Carlos', 'APROVADO')
		,(19736, 'Juliana', 'APROVADO')
		,(19162, 'Gabriel Hacker', 'REPROVADO')
		,(19718, 'Pedro Maciel', 'REPROVADO')
		,(19392, 'Paulo Gigante', 'REPROVADO')

	select * from tb2MtecB

	-- Merge

	merge tb3Mtec dest using tb2MtecA orig
	on dest.rmAluno = orig.rmAluno
	when not matched and orig.statusAluno like 'APROVADO' then
		insert values(orig.rmAluno, orig.nomeAluno);


	merge tb3Mtec dest using tb2MtecB orig
	on dest.rmAluno = orig.rmAluno
	when not matched and orig.statusAluno like 'APROVADO' then
		insert values(orig.rmAluno, orig.nomeAluno);

	select * from tb3Mtec