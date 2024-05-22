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
 MOT_CNH CHAR(11) NOT NULL,
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
 END_LATITUDE DECIMAL(10,8),
 END_LONGITUDE DECIMAL(10,8)
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
 END_ID INT NOT NULL,
 
 FOREIGN KEY(MOT_ID) REFERENCES MOT_HAS_VEI(MOT_ID),
 FOREIGN KEY(VEI_ID) REFERENCES MOT_HAS_VEI(VEI_ID),
 FOREIGN KEY(END_ID) REFERENCES END_ENDERECOS(END_ID)
);

CREATE TABLE PAS_IN_CAR(
 PIC_ID INT PRIMARY KEY AUTO_INCREMENT,
 PAS_ID INT NOT NULL,
 CAR_ID INT NOT NULL,
 
 FOREIGN KEY(PAS_ID) REFERENCES PAS_PASSAGEIROS(PAS_ID),
 FOREIGN KEY(CAR_ID) REFERENCES CAR_CARONAS(CAR_ID)
);

-- INSERT'S DE TESTE (MODELO E MARCA)
INSERT INTO MAR_MARCAS (MAR_ID, MAR_NOME) VALUES
(0, 'Chevrolet'),
(0, 'Fiat'),
(0, 'Volkswagen'),
(0, 'Ford'),
(0, 'Toyota'),
(0, 'Honda'),
(0, 'Hyundai'),
(0, 'Renault'),
(0, 'Nissan'),
(0, 'Jeep'),
(0, 'Peugeot'),
(0, 'Citroën'),
(0, 'Kia'),
(0, 'Mitsubishi'),
(0, 'Suzuki'),
(0, 'BMW'),
(0, 'Mercedes-Benz'),
(0, 'Audi'),
(0, 'Volvo'),
(0, 'Land Rover'),
(0, 'Porsche'),
(0, 'Jaguar'),
(0, 'Lexus'),
(0, 'Subaru'),
(0, 'Chery'),
(0, 'Caoa Chery'),
(0, 'JAC Motors'),
(0, 'BYD'),
(0, 'Tesla'),
(0, 'Dodge'),
(0, 'Ram'),
(0, 'MINI'),
(0, 'Maserati'),
(0, 'Ferrari'),
(0, 'Lamborghini'),
(0, 'Aston Martin'),
(0, 'Alfa Romeo'),
(0, 'Bentley'),
(0, 'Rolls-Royce'),
(0, 'Bugatti'),
(0, 'McLaren'),
(0, 'SsangYong'),
(0, 'Mahindra'),
(0, 'Lifan'),
(0, 'Troller'),
(0, 'Geely'),
(0, 'MG'),
(0, 'Great Wall Motors (GWM)'),
(0, 'Foton'),
(0, 'Iveco'),
(0, 'Scania'),
(0, 'MAN'),
(0, 'Agrale'),
(0, 'Chrysler'),
(0, 'Acura'),
(0, 'Infiniti'),
(0, 'DS Automobiles'),
(0, 'Genesis'),
(0, 'Lincoln'),
(0, 'Buick'),
(0, 'Cadillac'),
(0, 'Seat'),
(0, 'Skoda'),
(0, 'Tata Motors'),
(0, 'Rivian'),
(0, 'Lucid Motors'),
(0, 'Fisker'),
(0, 'Polestar'),
(0, 'Cupra'),
(0, 'Opel'),
(0, 'Vauxhall'),
(0, 'Haval'),
(0, 'Borgward'),
(0, 'Zotye'),
(0, 'Luxgen'),
(0, 'Saic Motors'),
(0, 'BAIC'),
(0, 'Dongfeng'),
(0, 'Changan'),
(0, 'Roewe'),
(0, 'FAW'),
(0, 'Haima'),
(0, 'Wey'),
(0, 'Hongqi'),
(0, 'Ora'),
(0, 'Everus'),
(0, 'Venucia'),
(0, 'GAC'),
(0, 'Yema'),
(0, 'NIO'),
(0, 'Li Auto'),
(0, 'Xpeng Motors'),
(0, 'Wuling'),
(0, 'Karma'),
(0, 'Faraday Future'),
(0, 'Canoo'),
(0, 'Arrival'),
(0, 'Lordstown Motors'),
(0, 'Bollinger Motors'),
(0, 'ElectraMeccanica');

INSERT INTO MOD_MODELOS (MOD_ID, MOD_NOME) VALUES
(0, 'Chevrolet Onix'),
(0, 'Chevrolet Tracker'),
(0, 'Chevrolet Spin'),
(0, 'Chevrolet Cruze'),
(0, 'Chevrolet S10'),
(0, 'Fiat Argo'),
(0, 'Fiat Cronos'),
(0, 'Fiat Toro'),
(0, 'Fiat Mobi'),
(0, 'Fiat Strada'),
(0, 'Volkswagen Gol'),
(0, 'Volkswagen Polo'),
(0, 'Volkswagen Virtus'),
(0, 'Volkswagen T-Cross'),
(0, 'Volkswagen Nivus'),
(0, 'Ford Ka'),
(0, 'Ford EcoSport'),
(0, 'Ford Ranger'),
(0, 'Ford Territory'),
(0, 'Toyota Corolla'),
(0, 'Toyota Yaris'),
(0, 'Toyota Hilux'),
(0, 'Toyota SW4'),
(0, 'Toyota Corolla Cross'),
(0, 'Honda Civic'),
(0, 'Honda City'),
(0, 'Honda HR-V'),
(0, 'Honda WR-V'),
(0, 'Honda Fit'),
(0, 'Hyundai HB20'),
(0, 'Hyundai Creta'),
(0, 'Hyundai Tucson'),
(0, 'Hyundai Santa Fe'),
(0, 'Hyundai Kona'),
(0, 'Renault Kwid'),
(0, 'Renault Sandero'),
(0, 'Renault Logan'),
(0, 'Renault Duster'),
(0, 'Renault Captur'),
(0, 'Nissan Kicks'),
(0, 'Nissan Versa'),
(0, 'Nissan Sentra'),
(0, 'Nissan Frontier'),
(0, 'Jeep Renegade'),
(0, 'Jeep Compass'),
(0, 'Jeep Commander'),
(0, 'Peugeot 208'),
(0, 'Peugeot 2008'),
(0, 'Peugeot 3008'),
(0, 'Citroën C3'),
(0, 'Citroën C4 Cactus'),
(0, 'Citroën C5 Aircross'),
(0, 'Kia Seltos'),
(0, 'Kia Sportage'),
(0, 'Kia Cerato'),
(0, 'Mitsubishi ASX'),
(0, 'Mitsubishi Outlander'),
(0, 'Mitsubishi Pajero'),
(0, 'Suzuki Vitara'),
(0, 'Suzuki Jimny'),
(0, 'BMW X1'),
(0, 'BMW Série 3'),
(0, 'Mercedes-Benz Classe A'),
(0, 'Mercedes-Benz GLA'),
(0, 'Audi A3'),
(0, 'Audi Q3'),
(0, 'Volvo XC40'),
(0, 'Volvo XC60'),
(0, 'Land Rover Evoque'),
(0, 'Porsche Macan'),
(0, 'Porsche Cayenne'),
(0, 'Jaguar E-Pace'),
(0, 'Lexus NX'),
(0, 'Subaru XV'),
(0, 'Chery Tiggo 5x'),
(0, 'Caoa Chery Tiggo 8'),
(0, 'JAC T60'),
(0, 'BYD Song'),
(0, 'Tesla Model 3'),
(0, 'Tesla Model Y'),
(0, 'Dodge Durango'),
(0, 'Ram 1500'),
(0, 'MINI Cooper'),
(0, 'Maserati Levante'),
(0, 'Ferrari Roma'),
(0, 'Lamborghini Urus'),
(0, 'Aston Martin DBX'),
(0, 'Alfa Romeo Giulia'),
(0, 'Bentley Bentayga'),
(0, 'Rolls-Royce Cullinan'),
(0, 'Bugatti Chiron'),
(0, 'McLaren GT'),
(0, 'SsangYong Tivoli'),
(0, 'Mahindra Scorpio'),
(0, 'Lifan X60'),
(0, 'Troller T4'),
(0, 'Geely Emgrand'),
(0, 'MG ZS'),
(0, 'Great Wall H6'),
(0, 'Foton Tunland');

SELECT * FROM USU_USUARIO;
SELECT * FROM PAS_PASSAGEIROS;
SELECT * FROM MOT_MOTORISTAS;
SELECT * FROM MAR_MARCAS;
SELECT * FROM VEI_VEICULOS;
SELECT * FROM MOD_MODELOS;