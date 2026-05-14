CREATE DATABASE driveZ;
USE driveZ;

CREATE TABLE tbl_cliente (
id_cliente int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
telefone varchar(14) null,
img_perfil blob null,
cpf varchar(11)  null unique,
cnpj varchar(14)  null unique,
senha varchar(100) not null
);

CREATE TABLE tbl_prestador (
id_prestador int primary key auto_increment,
nome varchar(100) not null,
email varchar(100) not null,
telefone varchar(14) null,
img_perfil blob null,
cpf varchar(11) null unique,
cnh varchar(12) null unique,
cnpj varchar(14) null unique,
senha varchar(100) not null,
categoria VARCHAR(150) null,
descricao VARCHAR(300) null
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

CREATE TABLE tbl_status(
id_status int primary key auto_increment,
status boolean not null,
id_pedido int not null,
FOREIGN KEY (id_pedido) REFERENCES tbl_pedido (id_pedido)
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
enviado_por enum('cliente','prestador') not null,
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


SELECT * FROM tbl_cliente;
SELECT * FROM tbl_prestador;
SELECT * FROM tbl_veiculo;
SELECT * FROM tbl_servicos;
SELECT * FROM tbl_endereco;
SELECT * FROM tbl_pedido;
SELECT * FROM tbl_avaliacao;
SELECT * FROM tbl_mensagem;
SELECT * FROM tbl_veiculo_prestador;
SELECT * FROM tbl_veiculo_cliente;
SELECT * FROM tbl_prestador_servico;
SELECT * FROM tbl_prestador_endereco;
SELECT * FROM tbl_cliente_endereco;
SELECT * FROM tbl_status;



-- Relatorio completo
SELECT 
    p.id_pedido AS 'Nº Pedido',
    ANY_VALUE(p.status_pedido) AS 'Status',
    ANY_VALUE(p.data_solicitacao) AS 'Data',
    ANY_VALUE(p.descricao) AS 'O que foi pedido',
    -- Dados do Cliente e seu Veículo
    ANY_VALUE(c.nome) AS 'Cliente',
    ANY_VALUE(v_cli.placa) AS 'Placa Cli',
    -- Dados do Prestador e seu Veículo
    ANY_VALUE(pr.nome) AS 'Prestador',
    ANY_VALUE(v_pre.placa) AS 'Placa Prest',
    -- Localização
    ANY_VALUE(p.endereco_origem) AS 'Origem',
    ANY_VALUE(p.endereco_destino) AS 'Destino',
    ANY_VALUE(e_cli.cidade) AS 'Cidade Cliente',
    ANY_VALUE(e_pre.cidade) AS 'Cidade Prestador',
    -- Avaliação
    ANY_VALUE(a.nota) AS 'Nota',
    ANY_VALUE(a.comentario) AS 'Feedback'
FROM tbl_pedido p
JOIN tbl_cliente c ON p.id_cliente = c.id_cliente
LEFT JOIN tbl_veiculo_cliente vc ON c.id_cliente = vc.id_cliente
LEFT JOIN tbl_veiculo v_cli ON vc.id_veiculo = v_cli.id_veiculo
LEFT JOIN tbl_cliente_endereco ce ON c.id_cliente = ce.id_cliente
LEFT JOIN tbl_endereco e_cli ON ce.id_endereco = e_cli.id_endereco
JOIN tbl_prestador pr ON p.id_prestador = pr.id_prestador
LEFT JOIN tbl_veiculo_prestador vp ON pr.id_prestador = vp.id_prestador
LEFT JOIN tbl_veiculo v_pre ON vp.id_veiculo = v_pre.id_veiculo
LEFT JOIN tbl_prestador_endereco pe ON pr.id_prestador = pe.id_prestador
LEFT JOIN tbl_endereco e_pre ON pe.id_endereco = e_pre.id_endereco
LEFT JOIN tbl_avaliacao a ON p.id_pedido = a.id_pedido
GROUP BY p.id_pedido;





-- TESTE VIEWS 

CREATE VIEW vw_resumo_pedidos AS
SELECT 
    p.id_pedido,
    c.nome AS nome_cliente,
    pr.nome AS nome_prestador,
    p.status_pedido,
    p.data_solicitacao
FROM tbl_pedido p
JOIN tbl_cliente c ON p.id_cliente = c.id_cliente
JOIN tbl_prestador pr ON p.id_prestador = pr.id_prestador;

SELECT * FROM vw_resumo_pedidos;


-- view da tela mensagem 
CREATE OR REPLACE VIEW vw_chat_dinamico AS
SELECT 
    m.id_pedido,
    m.data_envio,
    m.texto_mensagem,
    CASE 
        WHEN m.id_cliente IS NOT NULL THEN c.nome 
        ELSE p.nome 
    END AS nome_autor,
    CASE 
        WHEN m.id_cliente IS NOT NULL THEN c.img_perfil 
        ELSE p.img_perfil 
    END AS foto_autor,
    CASE 
        WHEN m.id_cliente IS NOT NULL THEN 'CLIENTE' 
        ELSE 'PRESTADOR' 
    END AS mensagem_autor
FROM tbl_mensagem m
LEFT JOIN tbl_cliente c ON m.id_cliente = c.id_cliente
LEFT JOIN tbl_prestador p ON m.id_prestador = p.id_prestador;

SELECT * FROM vw_chat_dinamico;

-- view da tela historico pedidos, (cliente e prestador)
CREATE OR REPLACE VIEW vw_historico_pedidos_finalizados AS
SELECT 
    p.id_pedido,            
    p.id_cliente,
    p.id_prestador,            
    pr.nome AS nome_prestador,
    c.nome AS nome_cliente,
    p.endereco_origem,
    p.endereco_destino,
    p.data_solicitacao AS data_pedido
FROM tbl_pedido p
JOIN tbl_cliente c ON p.id_cliente = c.id_cliente
JOIN tbl_prestador pr ON p.id_prestador = pr.id_prestador
WHERE p.status_pedido = 'Finalizado';

-- select abaixo se precisar para montar!
SELECT 
    id_pedido,
      id_cliente,
    id_prestador,
    nome_cliente,
    nome_prestador, 
    endereco_origem, 
    endereco_destino, 
    data_pedido
FROM vw_historico_pedidos_finalizados
WHERE id_cliente = 1;


-- TRIGGERS 

-- Finalizar Pedido, esta funcionando!

DELIMITER //
CREATE TRIGGER trg_finalizar_pedido_apos_avaliacao
AFTER INSERT ON tbl_avaliacao
FOR EACH ROW
BEGIN
    UPDATE tbl_pedido 
    SET status_pedido = 'Finalizado'
    WHERE id_pedido = NEW.id_pedido;
END //
DELIMITER ;



-- testando a trigger "trg_finalizar_pedido_apos_avaliacao"
INSERT INTO tbl_avaliacao (id_pedido, nota, comentario) 
VALUES (11, 5, 'Serviço excelente!');
DELETE FROM tbl_avaliacao WHERE id_pedido = 8;
SELECT id_pedido, status_pedido FROM tbl_pedido WHERE id_pedido = 11;


-- Validar Autor Da mensagem. esta funcionando!
DELIMITER //
CREATE TRIGGER trg_validar_autor_mensagem
BEFORE INSERT ON tbl_mensagem
FOR EACH ROW
BEGIN
	IF (NEW.id_cliente IS NULL AND NEW.id_prestador IS NULL) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A mensagem deve ter um autor (Cliente ou Prestador).';
    END IF;
END //
DELIMITER ;

-- testando a trigger "trg_validar_autor_mensagem"
INSERT INTO tbl_mensagem (id_pedido, id_cliente, id_prestador, texto_mensagem)
VALUES (1, NULL, NULL, 'Essa mensagem não deve passar!');


SELECT * FROM vw_chat_dinamico WHERE id_pedido = 1;

-- Bloquear avaliacao dupla no sistema, esta funcionando!
DELIMITER //
CREATE TRIGGER trg_bloquear_avaliacao_dupla
BEFORE INSERT ON tbl_avaliacao
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM tbl_avaliacao WHERE id_pedido = NEW.id_pedido) > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Este pedido já foi avaliado!';
    END IF;
END //
DELIMITER ;


-- TESTE DE NOVAS TRIGGERS --

-- Garante que a data do pedido seja o momento exato da inserção, trigger funcionando
DELIMITER $$
CREATE TRIGGER tr_data_pedido_insert
BEFORE INSERT ON tbl_pedido
FOR EACH ROW
BEGIN
    IF NEW.data_solicitacao IS NULL THEN
        SET NEW.data_solicitacao = NOW();
    END IF;
END$$
DELIMITER ;


-- Garante que a data da mensagem seja o momento exato do envio, trigger funcionando!
DELIMITER $$
CREATE TRIGGER tr_data_mensagem_insert
BEFORE INSERT ON tbl_mensagem
FOR EACH ROW
BEGIN
    SET NEW.data_envio = NOW();
END$$
DELIMITER ;


-- Impede que o pedido "CLIENTE" seja feito sem cpf ou cnpj, trigger funcionando!
DELIMITER $$
CREATE TRIGGER tr_valida_documento_cliente_update
BEFORE UPDATE ON tbl_cliente
FOR EACH ROW
BEGIN
    -- Só valida se ele estiver tentando mexer nos campos de documento
    IF NEW.cpf IS NULL AND NEW.cnpj IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Para completar o cadastro, insira ao menos um CPF ou CNPJ.';
    END IF;
END$$
DELIMITER ;


-- Impede que o pedido "PRESTADOR" seja feito sem cpf ou cnpj, trigger funcionando!
DELIMITER $$
CREATE TRIGGER tr_valida_documento_prestador_update
BEFORE UPDATE ON tbl_prestador
FOR EACH ROW
BEGIN
    IF NEW.cpf IS NULL AND NEW.cnpj IS NULL THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'O prestador deve possuir pelo menos um CPF ou CNPJ.';
    END IF;
    -- Se você quiser garantir que o prestador sempre tenha telefone ao atualizar
    IF NEW.telefone IS NULL OR NEW.telefone = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O prestador precisa de um telefone para contato.';
    END IF;
END$$
DELIMITER ;


-- impede que o pedido seja feito se o cliente nao tiver feito todo o cadastro obrigatorio
DELIMITER $$
CREATE TRIGGER tr_valida_cadastro_antes_pedido
BEFORE INSERT ON tbl_pedido
FOR EACH ROW
BEGIN
    DECLARE v_telefone VARCHAR(14);
    DECLARE v_cpf VARCHAR(11);
    DECLARE v_cnpj VARCHAR(14);
    -- Busca os dados do cliente que está tentando fazer o pedido
    SELECT telefone, cpf, cnpj 
    INTO v_telefone, v_cpf, v_cnpj
    FROM tbl_cliente
    WHERE id_cliente = NEW.id_cliente;
    -- Verifica se o telefone está preenchido
    IF v_telefone IS NULL OR v_telefone = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Complete seu cadastro (telefone) para realizar pedidos.';
    END IF;
    -- Verifica se existe pelo menos um documento (CPF ou CNPJ)
    IF v_cpf IS NULL AND v_cnpj IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Erro: Complete seu cadastro (CPF ou CNPJ) para realizar pedidos.';
    END IF;
END$$
DELIMITER ;
