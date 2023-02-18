-- DESAFIO OFICINA

create database oficina;
use oficina;

create table Cliente(
	idCliente int auto_increment primary key,
    Fnome varchar (50) not null,
    Lname varchar (50) not null,
    cpf char (11) unique,
    contato varchar (9) not null
);
-- drop table oficina;
create table Oficina(
	idOficina int primary key,
    cnpj char (15) unique,
    endereco varchar (200),
    contato varchar (10) 
);

create table eqRevisao(
	ideqRevisao int primary key,
    idClienteR int,
    equipeFuncionaios varchar (50),
    pecas varchar (20) not null,
    valorMO float not null,
    constraint fk_revisao_cliente foreign key (idClienteR) references Cliente(idCliente)
    
    );


create table eqConcerto(
	ideqConcerto int primary key,
    idclienteC int,
    equipeFuncionaios varchar (50),
    pecas varchar (20) not null,
    valorMO float not null,
    constraint fk_concerto_cliente foreign key (idclienteC) references Cliente(idCliente)
    );
    
    
create table OServico(
	idOServico int auto_increment primary key,
    idOSconcerto int,
    idOSrevisao int,
    tipoServico enum('revisao', 'conserto', 'em analise') default 'em analise',
    valorOs float default 0,
    constraint fk_OrdemServico_concerto foreign key (idOSconcerto) references eqConcerto(ideqConcerto),
    constraint fk_OrdemServico_revisao foreign key (idOSrevisao) references eqRevisao(ideqRevisao)
);

create table pagamento(
	idPagemnto int auto_increment primary key,
    idOServico int,
    tipoPagamento enum('boleto','cartao-debito','cartao-credito') not null,
    constraint fk_pagamento_servico foreign key (idOServico) references OServico(idOServico)
);



                                        -- DADOS --



-- dados clientes
-- idCliente, Fnome, Lname, cpf, contato
insert into cliente (Fnome, Lname, cpf, contato)
			values  ('gustavo', 'lopes', 12345678911,99999999),
					('yana', 'lopes', 12345678922,88888888),
                    ('daniele', 'santos', 12345678933,77777777),
                    ('joao', 'lima', 12345678944, 66666666),
                    ('vitoria', 'santos', 12345678955, 55555555);

-- dados oficina
-- idOficina, cnpj, endereco, contato
insert into oficina (idOficina, cnpj, endereco, contato)
			values (1, 123456789012345, 'rua da luz,55, branca - campo grande', 33223322);
          

-- dados eqRevisao
insert into eqRevisao (ideqRevisao, idClienteR, equipeFuncionaios, pecas, valorMO)
			values (1, 1, 'equipe alfa', 'oleo', 150.0),
					(2, 2, 'equipe alfa', 'filtro ar', 200.0),
                    (3, 3, 'equipe alfa', 'pastilha freio', 350.00),
                    (4, 4, 'equipe beta', 'trocou tudo', 5000.0); 
 
-- dados eqConcerto                   
insert into eqConcerto (ideqConcerto, idclienteC, equipeFuncionaios, pecas, valorMO)
			values (5,5,'equipe omega', 'motor', 10000.0); 
            

select * from eqRevisao;
-- dados OServico
-- tipo servico - 'revisao', 'conserto', 'em analise'
insert into OServico( idOSconcerto, idOSrevisao, tipoServico, valorOs)
			values (null,1,'revisao',150.0),
					(null,2,'revisao',200.0),
                    (null,3,'revisao',350.00),
                    (null,4, default,5000.0),
                    (5,null,'conserto',10000.0);

select * from OServico;
-- dados pagamento
-- tipos de pagamentos - 'boleto','cartao-debito','cartao-credito'
insert into pagamento (idOServico,tipoPagamento)
			values  (11,'boleto'),
					(12,'cartao-debito'),
                    (13,'boleto'),
                    (14,'cartao-credito'),
                    (15,'cartao-credito');
					
 
                    
                    
                    --         CONSULTAS DE DADOS
                    
select concat(fnome,' ',lname) as cliente, idcliente as ncadastro from cliente
				order by idcliente;
                
select count(*) from pagamento;