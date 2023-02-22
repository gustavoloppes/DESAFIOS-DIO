
create schema if not exists company;
create table company.employee(
	Fname varchar(15) not null,
    Minit char,
    Lname varchar(15) not null,
    Ssn char(9) not null,
    Bdate date,
    Address varchar(30),
    sex char,
    Salary decimal(10,2),
    Super_ssn char(9),
    Dno int not null,
    primary key (Ssn)
);

use company;
create table departament(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char (9),
    Mgr_start_date date,
    Dept_create_date date,
    primary key (Dnumber),
    unique (Dname),
    foreign key (Mgr_ssn) references employee(Ssn)

);

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    primary key (Dnumber, Dlocation),
    foreign key (Dnumber) references departament(Dnumber)

);
    
create table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    unique (Pname),
    foreign key (Dnum) references departament(Dnumber)
    
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    foreign key (Essn) references employee(Ssn),
    foreign key (Pno) references project(Pnumber)

);

create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char, -- F OU M
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    foreign key (Essn) references employee(Ssn)

);


-- DESAFIO DIO, Parte 1 – Criando índices em Banco de Dados
/*
Perguntas:  

Qual o departamento com maior número de pessoas? 

Quais são os departamentos por cidade? 

Relação de empregrados por departamento 
*/

use company;

select dname,dnumber,mgr_Ssn,dno from departament d, employee e, dept_locations l
		where d.mgr_ssn = e.ssn and d.dnumber = l.dnumber
        group by dnumber;
        
-- numero de employee na table departamento
-- Qual o departamento com maior número de pessoas? 
CREATE INDEX index_dept_NumEmployee ON company.departament(mgr_ssn) USING btree;




-- CENARIO ECOMMERCE

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
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    Classification_kids bool default false,
    category enum('eletronico','vstuario','brinquedos','alimento','moveis') not null,
    avaliacao float default 0,
    size varchar (10)
); 
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
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);            
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(255) not null,
    CNPJ char(15) not null,
	contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);          

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


delimiter %
create procedure insert_into_cliente_proc(
in idCliente_p int,
in Fname_p varchar (10),
in Minit_p char (3),
in Lname_p char(15),
in CPF_p char (9),
in Address_p varchar (30)
)
begin
	if (cpf_p < 9 and cpf_p > 7) then
	insert into cliente (idCliente,Fname,Minit,Lname,CPF,Address) 
    values (idCliente_p,Fname_p,Minit_p,Lname_p,CPF_p,Address_p);
    
     else 
		select 'CPF INCORRETO' as Message_Erro;
	end if;

    
end %
delimiter %;


