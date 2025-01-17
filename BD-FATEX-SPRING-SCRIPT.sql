DROP DATABASE BD_FATEX_SPRING;
CREATE DATABASE BD_FATEX_SPRING;
USE BD_FATEX_SPRING;

SET GLOBAL time_zone = '-03:00';
SET time_zone = '-03:00';

CREATE TABLE USU_USUARIO(
 USU_ID INT PRIMARY KEY AUTO_INCREMENT,
 USU_EMAIL VARCHAR(255) NOT NULL UNIQUE,
 USU_SENHA VARCHAR(255) NOT NULL,
 USU_NOME VARCHAR(255) DEFAULT 'Usuario',
 USU_DT_NASCIMENTO DATE,
 USU_GENERO ENUM('M','F','O'),
 USU_TIPO ENUM('PASSAGEIRO','MOTORISTA') DEFAULT 'PASSAGEIRO',
 USU_CPF CHAR(11) UNIQUE,
 USU_TELEFONE CHAR(11)
);

CREATE TABLE PAS_PASSAGEIROS(
 PAS_ID INT PRIMARY KEY AUTO_INCREMENT,
 PAS_NOTA DECIMAL(2, 1) NOT NULL,
 PAS_QT_AVALIACOES INT NOT NULL,
 USU_ID INT NOT NULL UNIQUE,
 
 FOREIGN KEY(USU_ID) REFERENCES USU_USUARIO(USU_ID) ON UPDATE CASCADE
);

CREATE TABLE MOT_MOTORISTAS(
 MOT_ID INT PRIMARY KEY AUTO_INCREMENT,
 MOT_NOTA DECIMAL(2, 1) NOT NULL,
 MOT_CNH CHAR(11) NOT NULL UNIQUE,
 MOT_QT_AVALIACOES INT,
 USU_ID INT NOT NULL UNIQUE,
 
 FOREIGN KEY(USU_ID) REFERENCES USU_USUARIO(USU_ID) ON UPDATE CASCADE
);

CREATE TABLE END_ENDERECOS(
 END_ID INT PRIMARY KEY AUTO_INCREMENT,
 END_NUMERO INT NOT NULL,
 END_RUA VARCHAR(255) NOT NULL,
 END_BAIRRO VARCHAR(255) NOT NULL,
 END_CIDADE VARCHAR(255) NOT NULL,
 END_LATITUDE DOUBLE(10,8),
 END_LONGITUDE DOUBLE(10,8)
);

CREATE TABLE MOD_MODELOS(
 MOD_ID INT PRIMARY KEY AUTO_INCREMENT,
 MOD_NOME VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE MAR_MARCAS(
 MAR_ID INT PRIMARY KEY AUTO_INCREMENT,
 MAR_NOME VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE VEI_VEICULOS(
 VEI_ID INT PRIMARY KEY AUTO_INCREMENT,
 VEI_PLACA CHAR(8) NOT NULL UNIQUE,
 VEI_MAX_PASSAGEIROS INT NOT NULL,
 VEI_COR VARCHAR(255) NOT NULL,
 MOD_ID INT NOT NULL,
 MAR_ID INT NOT NULL,
 
 FOREIGN KEY(MOD_ID) REFERENCES MOD_MODELOS(MOD_ID) ON UPDATE CASCADE,
 FOREIGN KEY(MAR_ID) REFERENCES MAR_MARCAS(MAR_ID) ON UPDATE CASCADE
);

CREATE TABLE USU_HAS_END(
 USU_ID INT NOT NULL,
 END_ID INT NOT NULL,
 UHE_STATUS ENUM('ATIVO','INATIVO') DEFAULT 'ATIVO',
 
 FOREIGN KEY(USU_ID) REFERENCES USU_USUARIO(USU_ID) ON UPDATE CASCADE,
 FOREIGN KEY(END_ID) REFERENCES END_ENDERECOS(END_ID) ON UPDATE CASCADE,
 
 PRIMARY KEY(USU_ID, END_ID)
);

CREATE TABLE MOT_HAS_VEI(
 MOT_ID INT NOT NULL,
 VEI_ID INT NOT NULL,
 MHV_STATUS ENUM('ATIVO', 'INATIVO') DEFAULT 'ATIVO',
 
 FOREIGN KEY(MOT_ID) REFERENCES MOT_MOTORISTAS(MOT_ID) ON UPDATE CASCADE,
 FOREIGN KEY(VEI_ID) REFERENCES VEI_VEICULOS(VEI_ID) ON UPDATE CASCADE,
 
 PRIMARY KEY(MOT_ID, VEI_ID)
);

CREATE TABLE CAR_CARONAS(
 CAR_ID INT PRIMARY KEY AUTO_INCREMENT,
 CAR_DATA DATE NOT NULL,
 CAR_HORA TIME NOT NULL,
 CAR_PARTIDA INT NOT NULL,
 CAR_CHEGADA INT NOT NULL,
 CAR_VALOR_DOACAO DECIMAL(10,2) NOT NULL,
 CAR_STATUS ENUM('Agendada', 'Em_andamento', 'Cancelada', 'Concluida') NOT NULL,
 CAR_VAGAS INT,
 CAR_VALOR_MINIMO DOUBLE,
 MOT_ID INT,
 VEI_ID INT,
 
 FOREIGN KEY(CAR_PARTIDA) REFERENCES END_ENDERECOS(END_ID) ON UPDATE CASCADE,
 FOREIGN KEY(CAR_CHEGADA) REFERENCES END_ENDERECOS(END_ID) ON UPDATE CASCADE,
 FOREIGN KEY(MOT_ID) REFERENCES MOT_HAS_VEI(MOT_ID) ON UPDATE CASCADE,
 FOREIGN KEY(VEI_ID) REFERENCES MOT_HAS_VEI(VEI_ID) ON UPDATE CASCADE
);

CREATE TABLE PAS_IN_CAR(
 PIC_ID INT PRIMARY KEY AUTO_INCREMENT,
 PAS_ID INT NOT NULL,
 CAR_ID INT NOT NULL,
 
 FOREIGN KEY(PAS_ID) REFERENCES PAS_PASSAGEIROS(PAS_ID) ON UPDATE CASCADE,
 FOREIGN KEY(CAR_ID) REFERENCES CAR_CARONAS(CAR_ID) ON UPDATE CASCADE,
 
 UNIQUE(PAS_ID, CAR_ID)
);

SELECT * FROM USU_USUARIO;
SELECT * FROM PAS_PASSAGEIROS;
SELECT * FROM MOT_MOTORISTAS;
SELECT * FROM END_ENDERECOS;
SELECT * FROM MOD_MODELOS;
SELECT * FROM MAR_MARCAS;
SELECT * FROM VEI_VEICULOS;
SELECT * FROM USU_HAS_END;
SELECT * FROM MOT_HAS_VEI;
SELECT * FROM CAR_CARONAS;
SELECT * FROM PAS_IN_CAR;

INSERT INTO MAR_MARCAS VALUES 
(0, 'Toyota'),
(0, 'Volkswagen'),
(0, 'Ford'),
(0, 'Chevrolet'),
(0, 'Honda');

INSERT INTO MOD_MODELOS VALUES 
(0, 'Corolla'),
(0, 'Golf'),
(0, 'Fiesta'),
(0, 'Onix'),
(0, 'Civic');