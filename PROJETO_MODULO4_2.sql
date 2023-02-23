-- DESAFIO MODULO4 VIEWS

--                             CENARIO COMPANY


-- Número de empregados por departamento e localidade 
create view  relacao_employee_view as 
		select concat(Fname,Minit,Lname) as Name, Dlocation, Dno as Dept_number from employee, dept_locations
        where (select count(*) from employee where dnumber = dno);
        
-- Lista de departamentos e seus gerentes 
create view  dept_mgr_view as 
		select dnumber as Departamento, Mgr_ssn as Gerente from departament
        where dnumber = Mgr_ssn;
        
-- Projetos com maior número de empregados (ex: por ordenação desc) 
create view employee_project_view as 
	select Pnumber as Projeto,dnum, concat(Fname,' ', Lname) as Empregado, Ssn,dno as Numero_ID
    from project, employee
    where Dnum >= 1;

-- Lista de projetos, departamentos e gerentes 
create view Mgr_project_view as 
	select Pnumber as Projeto,dnum, Mgr_ssn as Gerente, Dnumber as Departamento
    from project, departament
    where Dnum = dnumer and mgr_ssn = Dnum;

-- criando usuario
create user 'gerente'@localhost identified by '5545849';
grant all privileges on employee_project_view to 'geral'@localhost;

create user 'dono'@localhost identified by '6568945';
grant all privileges on Mgr_project_view to 'dono'@localhost;


-- criando triggers
-- para deletar atributo ou table usando trigger deve se usar BEFORE DELETE OLD.ATTRIBUTE
-- precisa salvar em outra tabela


use company;

delimiter //
create trigger check_Mgr before update on departament
			for each row
            begin
	if (new.Mgr_ssn is null) then
		insert into departament(Message,Mgr_ssn) values(concat('Favor indicar uma gerente',new.Mgr_ssn));
	end if;
			end //
delimiter ;

delimiter //
create trigger delelte_employee before delete on departament
			for each row
            begin
	if (old.Ssn = 0) then
		insert into employee_demitido(Message,Ssn,EFname,Address) values('Funcionario no Banco de Dados Demitidos',old.Ssn,EFname,Address);
	end if;
			end //
delimiter ;

create table employee_demitido(
	idEdemitido int primary key,
    EFname varchar (50),
    Address Varchar(100),
    Ssn_e int,
    constraint fk_employee_demitido foreign key (Ssn_e) references employee(ssn)
    );






--                               CENARIO ECOMMERCE

-- VIEWS

-- Número de clientes cadastrados
create view  cliente_view as 
		select concat(Fname,Minit,Lname) as Name, CPF from cliente
        where count(*) >= 1;
        
-- Lista de vendedores e produtos 
create view  seller_prodc_view as 
		select prodQuantity as UnidadesDisponiveis,idPseller as vendedor from productSeller
        where prodQuantity > 1;
        
-- Relacao de ordem de servico por cliente
create view order_produc_view as 
	select oderStatus, orderDescription, concat(Fname,' ', Lname) as name, idcliente as cliente
    from cliente, orders
    where idOrderCliente = idcliente;

-- produto e localizacao
create view prodc_loc_view as 
	select idProduct, Pname as NomeProd, category,location
    from storageLocation, product
    where idLproduct = idProduct;

-- criando usuario
create user 'vendedor'@localhost identified by '5545849';
grant all privileges on seller_prodc_view to 'vendedor'@localhost;

create user 'cliente'@localhost identified by '6568945';
grant all privileges on cliente_view to 'cliente'@localhost;




