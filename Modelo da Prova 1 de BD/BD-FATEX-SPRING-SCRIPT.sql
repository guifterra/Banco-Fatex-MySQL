CREATE DATABASE BD_FATEX_SPRING;
USE BD_FATEX_SPRING;

CREATE TABLE USU_USUARIO(
 USU_ID INT PRIMARY KEY AUTO_INCREMENT,
 USU_EMAIL VARCHAR(255) NOT NULL UNIQUE,
 USU_SENHA VARCHAR(255) NOT NULL,
 USU_NOME VARCHAR(255) DEFAULT 'Usuario',
 USU_DT_NASCIMENTO DATE,
 USU_GENERO ENUM('M','F','O'),
 USU_TIPO ENUM('PASSAGEIRO','MOTORISTA') DEFAULT 'PASSAGEIRO',
 USU_CPF CHAR(11) UNIQUE
);

CREATE TABLE PAS_PASSAGEIROS(
 PAS_ID INT PRIMARY KEY AUTO_INCREMENT,
 PAS_NOTA DECIMAL(2, 1) NOT NULL,
 PAS_QT_AVALIACOES INT NOT NULL,
 USU_ID INT NOT NULL UNIQUE,
 
 FOREIGN KEY(USU_ID) REFERENCES USU_USUARIO(USU_ID)
);

CREATE TABLE MOT_MOTORISTAS(
 MOT_ID INT PRIMARY KEY AUTO_INCREMENT,
 MOT_NOTA DECIMAL(2, 1) NOT NULL,
 MOT_CNH CHAR(11) NOT NULL UNIQUE,
 MOT_QT_AVALIACOES INT,
 USU_ID INT NOT NULL UNIQUE,
 
 FOREIGN KEY(USU_ID) REFERENCES USU_USUARIO(USU_ID)
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
 
 FOREIGN KEY(MOD_ID) REFERENCES MOD_MODELOS(MOD_ID),
 FOREIGN KEY(MAR_ID) REFERENCES MAR_MARCAS(MAR_ID)
);

CREATE TABLE USU_HAS_END(
 USU_ID INT NOT NULL,
 END_ID INT NOT NULL,
 
 FOREIGN KEY(USU_ID) REFERENCES USU_USUARIO(USU_ID),
 FOREIGN KEY(END_ID) REFERENCES END_ENDERECOS(END_ID),
 
 PRIMARY KEY(USU_ID, END_ID)
);

CREATE TABLE MOT_HAS_VEI(
 MOT_ID INT NOT NULL,
 VEI_ID INT NOT NULL,
 
 FOREIGN KEY(MOT_ID) REFERENCES MOT_MOTORISTAS(MOT_ID),
 FOREIGN KEY(VEI_ID) REFERENCES VEI_VEICULOS(VEI_ID),
 
 PRIMARY KEY(MOT_ID, VEI_ID)
);

CREATE TABLE CAR_CARONAS(
 CAR_ID INT PRIMARY KEY AUTO_INCREMENT,
 CAR_DATA DATE NOT NULL,
 CAR_HORA TIME NOT NULL,
 CAR_PARTIDA VARCHAR(255) NOT NULL,
 CAR_CHEGADA VARCHAR(255) NOT NULL,
 CAR_VALOR_DOACAO DECIMAL(10,2) NOT NULL,
 CAR_STATUS ENUM('Agendada', 'Em andamento', 'Cancelada', 'Concluida'),
 MOT_ID INT NOT NULL,
 VEI_ID INT NOT NULL,
 
 FOREIGN KEY(MOT_ID) REFERENCES MOT_HAS_VEI(MOT_ID),
 FOREIGN KEY(VEI_ID) REFERENCES MOT_HAS_VEI(VEI_ID)
);

CREATE TABLE PAS_IN_CAR(
 PIC_ID INT PRIMARY KEY AUTO_INCREMENT,
 PAS_ID INT NOT NULL,
 CAR_ID INT NOT NULL,
 
 FOREIGN KEY(PAS_ID) REFERENCES PAS_PASSAGEIROS(PAS_ID),
 FOREIGN KEY(CAR_ID) REFERENCES CAR_CARONAS(CAR_ID),
 
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

INSERT INTO USU_USUARIO VALUES
(0, 'claudemir@fatec.sp.gov.br', 'Claudemir-123', 'Claudemir', '1999-01-01','M','PASSAGEIRO', '12345678900'),
(0, 'angellina@fatec.sp.gov.br', 'Angellina-123', 'Angellina', '2000-05-12','F','PASSAGEIRO', '98765432100'),
(0, 'alexandre@fatec.sp.gov.br', 'Alexandre-123', 'Alexandre', '2002-12-03','O','PASSAGEIRO', '23456789011'),
(0, 'cristiano@fatec.sp.gov.br', 'Cristiano-123', 'Cristiano', '1996-07-22','M','PASSAGEIRO', '87654321011'),
(0, 'gabriela@fatec.sp.gov.br' , 'Gabriela-123' , 'Gabriela' , '2003-01-25','F','PASSAGEIRO', '34567890122'),
(0, 'leonardo@fatec.sp.gov.br' , 'Leonardo-123' , 'Leonardo' , '2004-03-05','O','MOTORISTA', '76543210922'),
(0, 'priscilla@fatec.sp.gov.br', 'Priscilla-123', 'Priscilla', '2004-01-13','F','MOTORISTA', '45678901233'),
(0, 'welington@fatec.sp.gov.br', 'Welington-123', 'Welington', '1999-06-06','M','MOTORISTA', '65432109833'),
(0, 'ronaldinho@fatec.sp.gov.br', 'Ronaldinho-123', 'Ronaldinho', '1982-11-07','O','MOTORISTA', '56789012344'),
(0, 'dionisio@fatec.sp.gov.br', 'Dionisio-123', 'Dionisio', '2005-08-01','M','MOTORISTA', '54321098744');

INSERT INTO PAS_PASSAGEIROS VALUES
(0, 4.5, 10, 1),
(0, 3.3, 22, 2),
(0, 5.0, 07, 3),
(0, 4.2, 03, 4),
(0, 3.0, 18, 5),
(0, 2.5, 10, 6),
(0, 4.8, 19, 7),
(0, 4.9, 03, 8),
(0, 5.0, 15, 9),
(0, 3.7, 15, 10);

INSERT INTO MOT_MOTORISTAS VALUES
(0, 4.5, '12345678901', 10, 6),
(0, 5.0, '23456789012', 13, 7),
(0, 3.3, '34567890123', 15, 8),
(0, 5.0, '45678901234', 07, 9),
(0, 4.7, '56789012345', 22, 10);

INSERT INTO END_ENDERECOS VALUES 
(0, 123, 'Rua das Flores', 'Centro', 'São Paulo', -23.550520, -46.633308),
(0, 456, 'Avenida Paulista', 'Bela Vista', 'São Paulo', -23.561684, -46.656139),
(0, 789, 'Rua XV de Novembro', 'Centro', 'Curitiba', -25.428356, -49.273251),
(0, 101, 'Avenida Rio Branco', 'Centro', 'Rio de Janeiro', -22.906847, -43.176714),
(0, 202, 'Rua Sete de Setembro', 'Centro', 'Porto Alegre', -30.034647, -51.217658),
(0, 1501, 'Av. Prof. João Rodrigues', 'Jardim Esperanca', 'Guaratinguetá ', 0.000000000, 0.000000000);

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

INSERT INTO VEI_VEICULOS VALUES 
(0, 'ABC1234', 5, 'Prata', 1, 1),  -- Corolla, Toyota
(0, 'DEF5678', 4, 'Preto', 2, 2),  -- Golf, Volkswagen
(0, 'GHI9101', 5, 'Azul', 3, 3),   -- Fiesta, Ford
(0, 'JKL2345', 5, 'Branco', 4, 4), -- Onix, Chevrolet
(0, 'MNO6789', 5, 'Cinza', 5, 5);  -- Civic, Honda

INSERT INTO USU_HAS_END VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(3, 5),
(2, 1),
(4, 1),
(5, 1),
(4, 2),
(4, 3),
(6, 4);

INSERT INTO MOT_HAS_VEI VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 2),
(4, 3),
(5, 3),
(5, 2);

INSERT INTO CAR_CARONAS VALUES
(0, '2024-05-30', '08:00:00', '123 Rua das Flores, Centro, São Paulo', '1501 Av. Prof. João Rodrigues, Jardim Esperanca, Guaratinguetá', 5.00, 'Agendada', 1, 1),
(0, '2024-05-31', '09:30:00', '456 Avenida Paulista, Bela Vista, São Paulo', '1501 Av. Prof. João Rodrigues, Jardim Esperanca, Guaratinguetá', 4.00, 'Em andamento', 1, 2),
(0, '2024-06-01', '10:45:00', '1501 Av. Prof. João Rodrigues, Jardim Esperanca, Guaratinguetá', '789 Rua XV de Novembro, Centro, Curitiba', 6.00, 'Cancelada', 3, 3),
(0, '2024-06-02', '14:15:00', '1501 Av. Prof. João Rodrigues, Jardim Esperanca, Guaratinguetá', '101 Avenida Rio Branco, Centro, Rio de janeiro', 12.00, 'Concluida', 4, 4),
(0, '2024-06-03', '16:30:00', '202 Rua Sete de Setembro, Centro, Porto Alegre', '1501 Av. Prof. João Rodrigues, Jardim Esperanca, Guaratinguetá', 15.00, 'Agendada', 5, 5);

INSERT INTO PAS_IN_CAR VALUES
(0, 1, 1),
(0, 2, 1),
(0, 3, 1),
(0, 2, 2),
(0, 4, 2),
(0, 3, 3),
(0, 4, 4),
(0, 5, 5);