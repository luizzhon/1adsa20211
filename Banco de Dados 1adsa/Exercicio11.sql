-- LUIZ HENRIQUE OLIVEIRA NARDI RA: 01211089
CREATE DATABASE Exercicio11;
USE Exercicio11;

-- TABELA DEPARTAMENTO
CREATE TABLE Departamento (
idDepto INT PRIMARY KEY,
nomeDepto VARCHAR (40),
fkGerente INT,
dataInicioGer DATE
);

-- TABELA FUNCIONARIO
CREATE TABLE Funcionario (
idFunc INT PRIMARY KEY,
nomeFunc VARCHAR (30),
salario FLOAT,
CHECK (salario > 0),
sexo CHAR (1),
CHECK (sexo = 'm' OR sexo = 'f'),
fkSupervisor INT,
dataNasc DATE,
fkDepto INT,
FOREIGN KEY (fkDepto) REFERENCES Departamento (idDepto)
);

-- TABELA PROJETO
CREATE TABLE Projeto (
idProj INT PRIMARY KEY,
nomeProj VARCHAR (90),
localProj VARCHAR (80),
fkDepto INT,
FOREIGN KEY (fkDepto) REFERENCES Departamento (idDepto)
);

-- TABELA FUNCPROJ
CREATE TABLE FuncProj (
fkFunc INT,
fkProj INT,
PRIMARY KEY (fkFunc, fkProj),
horas DECIMAL (3,1),
FOREIGN KEY (fkFunc) REFERENCES Funcionario (idFunc),
FOREIGN KEY (fkProj) REFERENCES Projeto (idProj)
);

ALTER TABLE Departamento ADD FOREIGN KEY (fkGerente) REFERENCES Funcionario (idFunc);

INSERT INTO Departamento VALUES 
(105, 'Pesquisa', NULL, '2008-05-22'),
(104, 'Administração', NULL, '2015-01-01'),
(101, 'Matriz', NULL, '2001-06-19');

INSERT INTO Funcionario VALUES 
(1, 'João Silva', 3500, 'm', 2, '1985-01-09', 105),
(2, 'Fernando Wong', 4500, 'm', 8, '1975-12-08', 105),
(3, 'Alice Sousa', 2500, 'f', 7, '1988-01-09', 104),
(4, 'Janice Morais', 4300, 'f', 8, '1970-06-20', 104),
(5, 'Ronaldo Lima', 3800, 'm', 1, '1982-09-15', 105),
(6, 'Joice Leite', 2500, 'f', 1, '1992-01-09', 105),
(7, 'Antonio Pereira', 2500, 'm', 4, '1989-03-29', 104),
(8, 'Juliano Brito', 5500, 'm', NULL, '1957-11-10', 101);

INSERT INTO Projeto VALUES 
(1, 'Produto X', 'Santo André', 105),
(2, 'Produto Y', 'Itu', 105),
(3, 'Produto Z', 'São Paulo', 105),
(10, 'Informatização', 'Mauá', 104),
(20, 'Reorganização', 'São Paulo', 101),
(30, 'Beneficios', 'Mauá', 104);

INSERT INTO FuncProj VALUES 
(1, 1, 32.5),
(1, 2, 7.5),
(5, 3, 40.0),
(6, 1, 20.0),
(6, 2, 20.0),
(2, 2, 10.0),
(2, 3, 10.0),
(2, 10, 10.0),
(2, 20, 10.0),
(3, 30, 30.0),
(3, 10, 10.0),
(7, 10, 35.0),
(7, 30, 5.0),
(4, 30, 20.0),
(4, 20, 15.0),
(8, 20, NULL);

UPDATE Departamento SET fkGerente = 2 WHERE idDepto = 105;

UPDATE Departamento SET fkGerente = 7 WHERE idDepto = 104;

UPDATE Departamento SET fkGerente = 8 WHERE idDepto = 101;

SELECT * FROM Departamento;

SELECT * FROM Funcionario;

SELECT * FROM Projeto;

SELECT * FROM FuncProj;

-- INFELIZMENTE NÃO VAI DAR CERTO, POIS O IDFUNC NÃO PODE SER NULO.
INSERT INTO Funcionario VALUES
(null, "Cecilia Ribeiro", 2800, "f", null, "1980-04-05", 104);

-- NÃO VAI DAR CERTO, O ID 3 ESTÁ DUPLICADO.
INSERT INTO Funcionario VALUES
(3, "Alice Souza", 2800, "f", 4, "1980-04-05", 104);

-- NÃO VAI DAR CERTO, O FK 107 NÃO EXISTE.
INSERT INTO Funcionario VALUES 
(9, "Cecília Ribeiro", 2800, "f", 4, "1980-04-05", 107);

-- FUNCIONOUUUU ;)
INSERT INTO Funcionario VALUES
(9, "Cecília Ribeiro", 2800, "f", 4, "1980-04-05", 104);

-- FUNCIONOUUUU ;)
DELETE FROM FuncProj WHERE fkFunc = 3 AND fkProj = 10;

-- FUNCIONARIO ESTÁ ASSOCIADO A UM PROJETO.
DELETE FROM Funcionario WHERE idFunc = 4;

-- FUNCIONARIO ESTÁ ASSOCIADO A UM PROJETO.
DELETE FROM Funcionario WHERE idFunc = 2;

-- FUNCIONOUUUU ;)
UPDATE Funcionario SET salario = 2800 WHERE idFunc = 3;

-- FUNCIONOUUUU ;)
UPDATE Funcionario SET fkDepto = 101 WHERE idFunc = 3;

-- NÃO FUNCIONOU, POIS FK 107 NÃO EXISTE.
UPDATE Funcionario SET fkDepto = 107 WHERE idFunc = 3;

SELECT nomeFunc, dataNasc, salario FROM Funcionario WHERE nomeFunc = "João Silva";

SELECT DISTINCT salario FROM Funcionario;

SELECT salario FROM Funcionario ORDER BY nomeFunc;

SELECT * FROM Funcionario ORDER BY salario DESC;

SELECT * FROM Funcionario WHERE salario > 2000 AND salario < 4000;

SELECT nomeFunc, salario FROM Funcionario WHERE nomeFunc LIKE "j%";

SELECT nomeFunc, salario FROM Funcionario WHERE nomeFunc LIKE "%a";

SELECT nomeFunc, salario FROM Funcionario WHERE nomeFunc LIKE "__n%";

SELECT nomeFunc, dataNasc FROM Funcionario WHERE nomeFunc LIKE "%s____";

SELECT * FROM Funcionario INNER JOIN Departamento ON fkDepto = idDepto WHERE nomeDepto = "Pesquisa";

SELECT * FROM Funcionario INNER JOIN Departamento ON fkDepto = idDepto WHERE nomeDepto = "Pesquisa" AND salario > 3500;

SELECT * FROM Funcionario INNER JOIN Departamento ON fkDepto = idDepto WHERE nomeDepto = "Pesquisa" AND nomeFunc LIKE "J%";

SELECT Funcionario.idFunc AS Funcionario, Funcionario.nomeFunc AS NomeFuncionario, Supervisor.idFunc AS idSupervisor, Supervisor.nomeFunc AS NomeSupervisor
FROM Funcionario AS Funcionario
INNER JOIN Funcionario AS Supervisor
ON funcionario.fkSupervisor = Supervisor.idFunc;

SELECT Proj.idProj AS idProjeto, Proj.fkDepto AS 'Departamento' , Ger.nomeFunc AS Gerente, Ger.dataNasc AS 'Data Nascimento' FROM Projeto AS Proj
INNER JOIN Departamento ON fkDepto = idDepto INNER JOIN Funcionario AS Ger ON fkGerente = idFunc 
WHERE Proj.localProj = 'São Paulo';

SELECT Func.idFunc AS idFuncionario, Func.nomeFunc AS Funcionario, FuncProj.fkProj AS Projeto, Proj.nomeProj AS 'Nome Projeto', FuncProj.horas AS 'Quantidade de Horas' FROM FuncProj AS FuncProj
INNER JOIN Funcionario AS Func ON fkFunc = idFunc INNER JOIN Projeto AS Proj ON fkProj = idProj;

SELECT nomeFunc FROM Funcionario WHERE dataNasc < "1980-01-01";

SELECT count(DISTINCT(salario)) AS "Salários diferentes" FROM Funcionario;

SELECT count(DISTINCT(localProj)) AS "Locais diferentes" FROM Projeto;

SELECT TRUNCATE(AVG(salario),2) AS "Média salarial", TRUNCATE(sum(salario),2) AS "Soma dos salários" FROM Funcionario;

SELECT min(salario), max(salario) FROM Funcionario;

SELECT idDepto, TRUNCATE(AVG(salario),2) AS "Média salarial", TRUNCATE(sum(salario),2) AS "Soma dos salários" FROM Funcionario INNER JOIN Departamento ON idDepto = fkDepto GROUP BY idDepto;

SELECT idDepto, min(salario), max(salario) FROM Funcionario INNER JOIN Departamento ON idDepto = fkDepto GROUP BY idDepto;

INSERT INTO Funcionario VALUES 
(10, "José da Silva", 1800, "m", 3, "2000-10-12", NULL),
(11, "Benedito Almeida", 1200, "m", 5, "2001-09-01", NULL);

INSERT INTO Departamento VALUES 
(110, "RH", 3, "2018-11-10");