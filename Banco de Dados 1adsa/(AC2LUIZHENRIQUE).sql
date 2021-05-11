create database ac2LUIZHENRIQUE;
use ac2LUIZHENRIQUE;
-- Tabela sobre Tarefa e Funcionário.
create table Tarefa (
idTarefa int primary key auto_increment,
nomeTarefa varchar(45) not null,
descricaoTarefa varchar (100) not null
);

create table Funcionario (
idFuncionario int primary key auto_increment,
nomeFuncionario varchar(45) not null,
telefoneFuncionario char (11) not null,
salario double not null,
funcaoFuncionario varchar (45) not null,
endereco varchar (45) not null,
logradouro varchar (45) not null,
fkTarefa int,
foreign key (fkTarefa) references Tarefa(idTarefa)
);

alter table Funcionario add check (salario > 0 );

desc Funcionario;

insert into Tarefa values
(null,'Faxineiro','Limpar'),
(null,'Analista','Analisar'),
(null,'Desenvolvedor','Desenvolver'),
(null,'Supervisor','Supervisionar'),
(null,'Padeiro','Fazer Pão');

insert into Funcionario values
(null,'Robsom','11954367843','1000','Catar o lixo','Italinos','Rua', 1),
(null,'Davi','11937584793','6000','Analisar dados','Taquaras','Estrada', 2),
(null,'Pedro','11969405993','7000','Desenvolver o código','Raizes','Rua', 3),
(null,'Patricia','11939275743','5000','Supervisiona','Flores','Avenida', 4),
(null,'Ewertom','11955760580','2000','Produzir Pão','Bons fins','Rua', 5);

select * from Tarefa;
select * from Funcionario;

select * from Tarefa inner join Funcionario
on fkTarefa = idTarefa;

select * from Tarefa inner join Funcionario 
on fkTarefa = idTarefa
where fkTarefa = "1";

select min(salario), max(salario) from Funcionario;

select sum(salario), avg(salario) from Funcionario
    where salario < 5000;
