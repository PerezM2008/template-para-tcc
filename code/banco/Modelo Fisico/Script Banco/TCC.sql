CREATE DATABASE driveZ;
USE driveZ;

CREATE TABLE tbl_cliente (
id_cliente int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
telefone varchar(14) not null,
img_perfil blob null,
cpf varchar(11) not null unique,
cnpj varchar(14) not null unique,
senha varchar(100) not null
);

CREATE TABLE tbl_prestador (
id_prestador int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
telefone varchar(14) not null,
img_perfil blob null,
cpf varchar(11) not null unique,
cnh varchar(12) not null unique,
cnpj varchar(14) not null unique,
senha varchar(100) not null
);

CREATE TABLE tbl_veiculo(
id_veiculo int primary key auto_increment,
categoria varchar(100),
validade date not null,
codigo_renavam varchar(15) not null unique,
placa varchar(7) not null unique
);

CREATE TABLE tbl_servicos(
id_servicos int primary key auto_increment,
nome_servico varchar(100) not null,
descricao_servico varchar(150) not null,
img_icone blob null
);

CREATE TABLE tbl_endereco(
id_endereco int primary key auto_increment,
cep varchar(8) not null,
uf varchar(2) not null,
cidade varchar(200) not null,
logradouro varchar(200) not null,
bairro varchar(200) not null
);

CREATE TABLE tbl_pedido(
id_pedido int primary key auto_increment,
status_pedido enum("Pendente","Em andamento","Finalizado") not null,
data_solicitacao datetime not null,
endereco_destino varchar(200) not null,
endereco_origem varchar(200) not null,
descricao varchar(150) not null,
distancia_km decimal(10,3) not null,
id_cliente int not null,
id_prestador int not null,
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente),
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador)
);

CREATE TABLE tbl_avaliacao(
id_avaliacao int primary key auto_increment,
nota decimal(3,1) null,
comentario varchar(150) null,
id_pedido int not null,
FOREIGN KEY (id_pedido) REFERENCES tbl_pedido (id_pedido)
);

CREATE TABLE tbl_mensagem(
id_mensagem int primary key auto_increment,
data_envio datetime not null,
texto_mensagem varchar(300) not null,
lida boolean not null,
imagem blob null,
id_pedido int not null,
id_prestador int not null,
id_cliente int not null,
FOREIGN KEY (id_pedido) REFERENCES tbl_pedido (id_pedido),
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador),
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente)
);

CREATE TABLE tbl_veiculo_prestador(
id_veiculo_prestador int primary key auto_increment,
id_veiculo int not null,
id_prestador int not null,
FOREIGN KEY (id_veiculo) REFERENCES tbl_veiculo (id_veiculo),
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador)
);

CREATE TABLE tbl_veiculo_cliente(
id_veiculo_cliente int primary key auto_increment,
id_veiculo int not null,
id_cliente int not null,
FOREIGN KEY (id_veiculo) REFERENCES tbl_veiculo (id_veiculo),
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente)
);

CREATE TABLE tbl_prestador_servico(
id_prestador_servico int primary key auto_increment,
id_prestador int not null,
id_servicos int not null,
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador),
FOREIGN KEY (id_servicos) REFERENCES tbl_servicos (id_servicos)
);

CREATE TABLE tbl_prestador_endereco(
id_prestador_endereco int primary key auto_increment,
id_prestador int not null,
id_endereco int not null,
FOREIGN KEY (id_prestador) REFERENCES tbl_prestador (id_prestador),
FOREIGN KEY (id_endereco) REFERENCES tbl_endereco (id_endereco)
);

CREATE TABLE tbl_cliente_endereco(
id_cliente_endereco int primary key auto_increment,
id_cliente int not null,
id_endereco int not null,
FOREIGN KEY (id_cliente) REFERENCES tbl_cliente (id_cliente),
FOREIGN KEY (id_endereco) REFERENCES tbl_endereco (id_endereco)
);

INSERT INTO tbl_cliente (nome, email, telefone, cpf, cnpj, senha) VALUES
('Ana Silva', 'ana.silva@email.com', '11988887777', '12345678901', '12345678000101', 'hash_senha_1'),
('Bruno Oliveira', 'bruno.o@provedor.com', '21977776666', '23456789012', '23456789000112', 'hash_senha_2'),
('Carla Souza', 'contato@carla.me', '31966665555', '34567890123', '34567890000123', 'hash_senha_3'),
('Diego Santos', 'diego.santos@web.com', '41955554444', '45678901234', '45678901000134', 'hash_senha_4'),
('Elena Martins', 'elena.m@empresa.com', '51944443333', '56789012345', '56789012000145', 'hash_senha_5'),
('Fabio Lima', 'fabio.lima@servidor.br', '61933332222', '67890123456', '67890123000156', 'hash_senha_6'),
('Gisele Rocha', 'gisele_rocha@mail.com', '71922221111', '78901234567', '78901234000167', 'hash_senha_7'),
('Hugo Ferreira', 'hugo.f@tech.com', '81911110000', '89012345678', '89012345000178', 'hash_senha_8'),
('Irene Costa', 'irene.costa@ig.com', '91900009999', '90123456789', '90123456000189', 'hash_senha_9'),
('João Mendes', 'joao.mendes@uol.com', '11912345678', '01234567890', '01234567000190', 'hash_senha_10');

INSERT INTO tbl_prestador (nome, email, telefone, cpf, cnh, cnpj, senha) VALUES
('Carlos Entregas', 'carlos@logistica.com', '11911112222', '10120230344', '123456789012', '11122233000101', 'hash_p1'),
('Marcos Reparos', 'marcos.reparos@email.com', '21922223333', '20230340455', '234567890123', '22233344000112', 'hash_p2'),
('Julia Reformas', 'contato@juliaref.com', '31933334444', '30340450566', '345678901234', '33344455000123', 'hash_p3'),
('Roberto Fretes', 'beto.fretes@uol.com', '41944445555', '40450560677', '456789012345', '44455566000134', 'hash_p4'),
('Luciana Pinturas', 'lu.pinturas@web.com', '51955556666', '50560770788', '567890123456', '55566677000145', 'hash_p5'),
('Ricardo Elétrica', 'ricardo.ele@gmail.com', '61966667777', '60670880899', '678901234567', '66677788000156', 'hash_p6'),
('Fernanda Limpeza', 'fer.limp@servicos.com', '71977778888', '70780990900', '789012345678', '77788899000167', 'hash_p7'),
('Paulo Hidráulica', 'paulo.hidro@ig.com', '81988889999', '80891001011', '890123456789', '88899900000178', 'hash_p8'),
('Sandra Mudanças', 'sandra.mud@empresa.br', '91999990000', '90901112122', '901234567890', '99900011000189', 'hash_p9'),
('Thiago Assistência', 'thiago.tec@outlook.com', '11900001111', '01012223233', '012345678901', '00011122000190', 'hash_p10');

INSERT INTO tbl_veiculo (categoria, validade, codigo_renavam, placa) VALUES
('Caminhão Baú', '2026-12-31', '12345678901', 'ABC1D23'),
('Van de Carga', '2025-10-15', '23456789012', 'EFG2H34'),
('Motocicleta', '2027-05-20', '34567890123', 'IJK3L45'),
('Utilitário', '2026-08-12', '45678901234', 'MNO4P56'),
('Caminhão Sider', '2025-11-30', '56789012345', 'QRS5T67'),
('Carro Passeio', '2028-01-10', '67890123456', 'UVW6X78'),
('Furgão', '2026-03-25', '78901234567', 'YZA7B89'),
('Caminhão Truck', '2025-09-05', '89012345678', 'BCD8E90'),
('Pickup', '2027-07-14', '90123456789', 'FGH9I01'),
('Caminhão Tanque', '2026-06-18', '01234567890', 'JKL0M12');

INSERT INTO tbl_servicos (nome_servico, descricao_servico) VALUES
('Revisão Geral', 'Check-up completo de motor, freios, suspensão e fluidos do veículo.'),
('Troca de Óleo e Filtro', 'Substituição de óleo lubrificante e filtros de ar e combustível.'),
('Manutenção de Freios', 'Troca de pastilhas, discos e verificação do sistema hidráulico.'),
('Reparo de Suspensão', 'Substituição de amortecedores, buchas e pivôs.'),
('Alinhamento e Balanceamento', 'Ajuste da geometria das rodas para evitar desgaste irregular.'),
('Mecânica de Motor', 'Reparos em cabeçote, correia dentada e sistemas internos.'),
('Diagnóstico Scanner', 'Leitura eletrônica de falhas na injeção e sensores do veículo.'),
('Manutenção de Câmbio', 'Reparo em transmissões manuais e automáticas.'),
('Sistema Elétrico', 'Reparo em alternadores, baterias e motor de arranque.'),
('Ar-Condicionado Automotivo', 'Carga de gás, higienização e reparo no compressor.');

INSERT INTO tbl_endereco (cep, uf, cidade, logradouro, bairro) VALUES
('01310100', 'SP', 'São Paulo', 'Avenida Paulista, 1000', 'Bela Vista'),
('20040002', 'RJ', 'Rio de Janeiro', 'Avenida Rio Branco, 156', 'Centro'),
('30140010', 'MG', 'Belo Horizonte', 'Rua da Bahia, 900', 'Lourdes'),
('70070010', 'DF', 'Brasília', 'SBS Quadra 1', 'Asa Sul'),
('80020010', 'PR', 'Curitiba', 'Rua XV de Novembro, 200', 'Centro'),
('90010190', 'RS', 'Porto Alegre', 'Rua dos Andradas, 500', 'Centro Histórico'),
('40020160', 'BA', 'Salvador', 'Praça da Sé, 10', 'Pelourinho'),
('60060390', 'CE', 'Fortaleza', 'Rua Guilherme Rocha, 300', 'Centro'),
('88010000', 'SC', 'Florianópolis', 'Rua Felipe Schmidt, 450', 'Centro'),
('69005000', 'AM', 'Manaus', 'Avenida Eduardo Ribeiro, 600', 'Centro');

INSERT INTO tbl_pedido (status_pedido, data_solicitacao, endereco_destino, endereco_origem, descricao, distancia_km, id_cliente, id_prestador) VALUES
('Pendente', '2026-04-20 10:30:00', 'Rua das Flores, 123', 'Av. Paulista, 1000', 'Troca de óleo e filtro', 5.500, 1, 1),
('Em andamento', '2026-04-21 14:00:00', 'Rua Rio Branco, 50', 'Rua da Bahia, 900', 'Manutenção de freios', 12.350, 2, 2),
('Finalizado', '2026-04-22 09:15:00', 'Av. Brasil, 2000', 'Rua XV de Novembro, 200', 'Revisão geral de suspensão', 8.100, 3, 3),
('Pendente', '2026-04-23 16:45:00', 'Rua dos Andradas, 300', 'Av. Eduardo Ribeiro, 600', 'Reparo no sistema elétrico', 3.200, 4, 4),
('Em andamento', '2026-04-24 08:30:00', 'Praça da Sé, 5', 'Rua Guilherme Rocha, 150', 'Diagnóstico via scanner', 15.000, 5, 5),
('Finalizado', '2026-04-24 11:00:00', 'Al. Santos, 450', 'Rua Augusta, 1200', 'Troca de pastilhas', 2.850, 6, 6),
('Pendente', '2026-04-24 13:20:00', 'Rua Chile, 22', 'Av. Sete de Setembro, 80', 'Carga de gás ar-condicionado', 7.400, 7, 7),
('Em andamento', '2026-04-24 15:10:00', 'Rua da Praia, 10', 'Av. Ipiranga, 500', 'Manutenção de embreagem', 22.600, 8, 8),
('Finalizado', '2026-04-24 16:00:00', 'Rua do Ouvidor, 15', 'Av. Rio Branco, 200', 'Alinhamento e balanceamento', 4.150, 9, 9),
('Pendente', '2026-04-24 17:30:00', 'Rua Direita, 100', 'Pátio do Colégio, 1', 'Reparo de motor de arranque', 1.500, 10, 10);

INSERT INTO tbl_avaliacao (nota, comentario, id_pedido) VALUES
(5.0, 'Serviço excelente! O mecânico foi muito rápido e educado.', 1),
(4.5, 'Muito bom, mas demorou um pouco para chegar ao local.', 2),
(5.0, 'Profissional extremamente qualificado, resolveu o problema de primeira.', 3),
(3.0, 'O serviço foi ok, mas o valor ficou um pouco acima do esperado.', 4),
(4.0, 'Bom atendimento, recomendo para serviços de suspensão.', 5),
(5.0, 'Impecável. Troca de pastilhas feita em tempo recorde.', 6),
(2.5, 'O ar-condicionado voltou a gelar, mas o prestador sujou o banco.', 7),
(4.8, 'Excelente custo-benefício. Voltarei a contratar.', 8),
(5.0, 'Alinhamento perfeito, o carro está outro.', 9),
(4.2, 'Atendimento atencioso e explicação técnica bem clara.', 10);

INSERT INTO tbl_mensagem (data_envio, texto_mensagem, lida, id_pedido, id_prestador, id_cliente) VALUES
('2026-04-24 10:35:00', 'Olá, já estou a caminho do local.', 1, 1, 1, 1),
('2026-04-24 10:37:00', 'Perfeito, ficarei aguardando na garagem.', 1, 1, 1, 1),
('2026-04-24 14:05:00', 'Pode me enviar uma foto da peça que precisa ser trocada?', 1, 2, 2, 2),
('2026-04-24 14:10:00', 'Vou tirar a foto agora e te mando.', 0, 2, 2, 2),
('2026-04-24 09:20:00', 'O serviço de suspensão foi finalizado com sucesso.', 1, 3, 3, 3),
('2026-04-24 16:50:00', 'Você trabalha com peças originais ou paralelas?', 1, 4, 4, 4),
('2026-04-24 16:55:00', 'Trabalho com ambas, depende da sua preferência.', 1, 4, 4, 4),
('2026-04-24 08:40:00', 'Estou tendo problemas para encontrar o endereço, pode confirmar?', 1, 5, 5, 5),
('2026-04-24 08:42:00', 'É na casa de portão azul, logo após o mercado.', 1, 5, 5, 5),
('2026-04-24 11:15:00', 'Obrigado pelo serviço, o carro ficou ótimo!', 0, 6, 6, 6);


SELECT * FROM tbl_cliente;
SELECT * FROM tbl_prestador;
SELECT * FROM tbl_veiculo;
SELECT * FROM tbl_servicos;
SELECT * FROM tbl_endereco;
SELECT * FROM tbl_pedido;
SELECT * FROM tbl_avaliacao;
SELECT * FROM tbl_mensagem;


