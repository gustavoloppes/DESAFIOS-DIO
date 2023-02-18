-- DESAFIO PROJETO LOGICO DE BANCO DE DADOS
-- drop database ecommerce;
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table cliente(
	idCliente int auto_increment primary key,
    Fname varchar(10),
    Minit char (3),
    Lname varchar (20),
    CPF char (11) not null,
    Address varchar (300),
    constraint unique_cpf_cliente unique (CPF)
); 

alter table cliente auto_increment=1;

-- criar tabela prodruto
-- size igual a dimensao do produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    Classification_kids bool default false,
    category enum('eletronico','vstuario','brinquedos','alimento','moveis') not null,
    avaliacao float default 0,
    size varchar (10)
); 

-- para ser continuado no desafio: termine de implementar a tabela necessaria 
-- alem disso, reflita essa modificacao no diagrama de esquema relacional 
-- criar constraints relacionadas ao pagamneto
-- create table payment(
	-- idCliente int,
	-- idPayment int,
	-- typePayment enum('boleto','dinheiro','dois cartoes'),
    -- limitAvailable float,
    -- primary key (idClient, id_payment));
    
     
-- criar tabela pedido
-- drop table orders;
create table orders(
	idOrder int auto_increment primary key,
    idOrderCliente int,
    oderStatus enum('cancelado','confirmado','em processamento') default 'em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
	paymentCash bool default false,
	constraint fk_orders_cliente foreign key (idOrderCliente) references cliente(idCliente)
				on update cascade
);          

-- criar estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);            

-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(255) not null,
    CNPJ char(15) not null,
	contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);          

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    socailName varchar(255) not null,
    abstName varchar (255),
    CPF char(9),
    CNPJ char(15),
    location varchar (255),
	contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
    );

-- produtos vendedor
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
	primary key (idPSeller,idPproduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproduct) references product(idProduct)
);
	
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
   poStatus enum('disponivel', 'sem estoque') default 'disponivel',
	primary key (idPOproduct,idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
   	primary key (idLproduct,idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
	primary key (idPsSupplier,idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);



show tables;
show databases;

-- recuperar constraints
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';









--             inserir os dados

use ecommerce;

-- idcliente,Fname,Minit,Lname,CPF,Address
insert into Cliente( Fname, Minit, Lname, CPF, Address)
			values ('maria', 'm', 'silva', '123456789', 'rua silva de prata 29, Garangola -Cidade das flores'),
				   ('matheus', 'o', 'pimentel', '123456798', 'rua costa de ouro 29, centro -Cidade das flores'),
                   ('ricardo', 'f', 'silva', '234567891', 'rua dai luiz 56, centro -Cidade das flores'),
                   ('julia', 's', 'franca', '345678912', 'rua yana lopes 17, Garangola -Cidade das flores'),
                   ('roberta', 'g', 'assis', '456789123', 'rua daniele santos 15, centro -Cidade das flores'),
                   ('isabela', 'm', 'cruz', '567891234', 'rua joao de assis 89, Garangola -Cidade das flores');

-- ipproduct, pname, classification_kids boolean, category('eletronico','vstuario','brinquedos','alimento','moveis), avaliacao, size
insert into product (Pname, classification_kids, category, avaliacao, size) 
			values  ('fone', false, 'eletronico', '4', null),
					('barbie', true, 'brinquedos', '3', null),
                    ('body c.', true, 'vstuario', '5', null),
                    ('microfone', false, 'eletronico', '4', null),
                    ('sofa', false, 'moveis', '3', '3x57x80'),
                    ('fire stick', false, 'eletronico', '3', null);

-- idOrdercliente, orderStatus, orderDescription, sendvalue, paymentCash
insert into orders (idOrdercliente, oderStatus, orderDescription, sendValue, paymentCash)
			values  (1, default, 'compra via aplicativo', null,1),
					(2, default, 'compra via aplicativo', null,50.0),
                    (3, 'confirmado', null, null,1),
                    (4, default, 'compra via web site', null,15);
		
-- ipPOproduct, idPOorder, poQuantity, poStatus
select * from product;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
			values  (7, 9, 2, null),
					(8, 10, 1, null),
                    (9, 11, 1, null);

-- storageLocation, quantity
insert into productStorage (storageLocation, quantity)
			values  ('rio de janeiro', '1000'),
					('rio de janeiro', '500'),
                    ('sao paulo', '10'),
                    ('sao paulo', '100'),
                    ('sao paulo', '10'),
                    ('brasilia', '60');

select * from product;                    
insert into storageLocation ( idLproduct, idLstorage, location)
			values (7,2,'RJ'),
				   (9,6,'GO');
                   
-- idsupplier, socialname, cnpj, contact
insert into supplier (socialName, CNPJ, contact)
			values  ('almeida e filhos', 123456789123456,'21985474'),
					('eletronica silva', 854519649143457,'21985484'),
                    ('eletronicos valma', 934567893934695,'21975474');

-- idPsSupplier, idPsProduct, quantity
insert into productSupplier (idPsSupplier, idPsProduct, quantity)
			values  (1,7,500),
					(1,8,400),
                    (2,9,633),
                    (3,10,5),
                    (2,11,10);

-- idseller, socialname, abstname, cnpj, cpf, location, contact
insert into seller (socailName, abstname, cnpj, cpf, location, contact)
			values  ('tech eletrocnicos', null, 123456789456321, null, 'rio de janeiro',219946287),
					('botique durgas', null, null, 123456783, 'rio de janeiro',219567895),
                    ('tech eletrocnicos', null, 456789123654485, null, 'sao paulo',1198657484);


-- idpseller, idpproduct, prodquality
insert into productseller (idpseller, idpproduct, prodQuantity)
			values  (1,7,80),
					(2,8,10);
                    
select * from productseller;






                                                   -- DESAFIO DIO --

show tables;
select * from orders;
select * from cliente;


-- recuperando dados cliente e ordem de pedido
select concat(Fname,' ', Lname) as nome_completo, oderstatus as status_pedido, orderdescription as descricao 
						from cliente c, orders o
						where c.idcliente = o.idOrderCliente
                        order by status_pedido;

 -- pedidos feitos por eles					
select * from cliente c, orders o where c.idcliente = idordercliente;

select concat(fname,' ',Lname) as cliente, idOrder as orders, oderStatus as Status_Order from cliente c, orders o 
where c.idcliente = idordercliente;

-- inserindo novo cliente
insert into orders (idOrdercliente, oderStatus, orderDescription, sendValue, paymentCash)
			values  (2, default, 'compra via aplicativo', null,1);

-- agrupar clientes
select * from cliente c, orders o 
		where c.idcliente = idordercliente
        group by idOrder;

select * from cliente c left outer join orders o  on c.idcliente = o.idordercliente
					inner join product on idOrder = idorder;
                    
                    