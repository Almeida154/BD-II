use bdHotel

insert into tbCliente(nomeCliente,dtNascCliente,cpfCliente)
values ('Walter Heisenberg','05-08-1980','101.845.029-88')
,('Bruce Benner','10-10-1991','535.091.238-08')
,('Tony Stark','06-07-1983','150.858.466-28')
select * from tbCliente

insert into tbReserva(dataReserva,horaReserva,codCliente,dataPrevistaCheckin,dataPrevistaCheckout,numHospedes,numAptos,valorReserva,valorEntrada)
values ('10/24/2021','18:00',1,'10/25/2021','11/28/2021',3,1,2700,800)
,('11/15/2020','13:00',2,'11/15/2020','11/20/2020',4,2,2800,700)
select * from tbReserva

insert into tbTipoApto(descricaoTipo)
values ('Single')
,('Medium')
,('Master')
select * from tbTipoApto

insert into tbApto(descricaoApto,andarApto,codTipoApto)
values ('2 camas, 1 banheiro, 1 frigobar',2,1)
,('4 camas, 2 banheiros, 2 frigobares',4,2)
,('6 camas, 2 banheiros, 4 frigobar, 1 hydro',15,3)
select * from tbApto

insert into tbReservaApto(codReserva,codTipoApto)
values (1,1)
,(2,2)
select * from tbReservaApto

insert into tbHospedagem(codReserva,codApto)
values (1,1)
,(2,2)
select * from tbHospedagem

insert into tbHospede(nomeHospede,dtNascHospede,emailHospede)
values ('Ricardo Ohara','02/03/1999','ricardoO@gmail.com')
,('Adriana Alameda','05/06/2008','adrmeida@gmail.com')
select * from tbHospede

insert into tbCheckin(dataHoraCheckin,dataHoraCheckout,codHospede,codHospedagem)
values ('09/23/2021 17:00','09/26/2021 17:00',1,1)
,('11/15/2021 13:00','11/30/2021 13:00',2,2)
select * from tbCheckin

insert into tbProduto(descricaoProduto,valorProduto,quantidadeProduto)
values ('Refrigerante Coca',10.00,30)
,('Refrigerante Fanta',9.00,20)
,('Salgadinho Cheetos', 15.00, 10)
select * from tbProduto

insert into tbConta(dataAberturaConta,dataFechamentoConta,codHospedagem,valorTotalConta)
values ('09/23/2021','09/25/2021',1,2013)
,('11/15/2021','11/20/2021',2,2813)
select * from tbConta

insert into tbContaProduto(codConta,codProduto,quantidade,subTotalContaProduto)
values (1,1,1,8.00)
,(2,2,1,5.00)
select * from tbContaProduto

insert into tbServico(descricaoServico,valorServico)
values ('Piscina',10.00)
,('Hidromassagem',15.00)
select * from tbServico

insert into tbContaServico(codConta,codServico,quantidade,subTotalContaServico)
values(1,1,1,10.00)
,(2,2,1,15.00)
select * from tbContaServico

insert into tbFormaPagto(descricaoFormaPagto)
values ('Débito')
,('Crédito')
select * from tbFormaPagto

insert into tbParcela(codFormaPagto,codConta,valorParcela)
values (1,1,200)
,(2,2,300.00)
select * from tbParcela


