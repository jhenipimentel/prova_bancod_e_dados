DROP DATABASE IF EXISTS prova_1;
CREATE DATABASE IF NOT EXISTS prova_1 CHARACTER SET utf8mb4;

USE prova_1;

CREATE TABLE cargos(
    id_cargo        INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cargo_usuario   ENUM('Estoquista','Vendedor','Secretario', 'Gerente', 'Diretor')
   
);

CREATE TABLE usuarios(
    id_usuario      INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_usuario    VARCHAR(255) NOT NULL,
    endereco        VARCHAR(255) NOT NULL,
    cargo_usuario   ENUM('Estoquista','Vendedor','Secretario', 'Gerente', 'Diretor'),
    id_cargo        INTEGER NOT NULL,
    FOREIGN KEY (id_cargo) REFERENCES cargos(id_cargo)
    
);

CREATE TABLE empresa(
    id_empresa      INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_empresa         ENUM('Nestle', 'Font life', 'Kibon')
);

CREATE TABLE produtos(
    id_produto      INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_produto    VARCHAR(255) NOT NULL,
    preco_compra    VARCHAR(255) NOT NULL,
    preco_venda     VARCHAR(255) NOT NULL,
    quantidade      VARCHAR(255) NOT NULL,
    id_empresa      INTEGER NOT NULL,
    FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE clientes(
    id_cliente      INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_cliente    VARCHAR(255) NOT NULL,
    cnpj_cpf        VARCHAR(255) NOT NULL,
    telefone        VARCHAR(255) NOT NULL,
    endereco        VARCHAR(255) NOT NULL
    
);

CREATE TABLE clientes_produtos(
    id_cliente      INTEGER NOT NULL,
    id_produto      INTEGER NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
     
);

CREATE TABLE usuarios_produtos(
    id_usuario     INTEGER NOT NULL,
    id_produto     INTEGER NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);

INSERT INTO cargos (cargo_usuario) VALUES
    ('Estoquista'),
    ('Vendedor'),
    ('Secretario'),
    ('Gerente'),
    ('Diretor');

SET @idEstoquista = (SELECT id_cargo FROM cargos WHERE cargos.cargo_usuario = "Estoquista");
SET @idVendedor = (SELECT id_cargo FROM cargos WHERE cargos.cargo_usuario = "Vendedor");
SET @idSecretario = (SELECT id_cargo FROM cargos WHERE cargos.cargo_usuario = "Secretario");
SET @idGerente = (SELECT id_cargo FROM cargos WHERE cargos.cargo_usuario = "Gerente");
SET @idDiretor = (SELECT id_cargo FROM cargos WHERE cargos.cargo_usuario = "Diretor");

INSERT INTO usuarios (nome_usuario, endereco, cargo_usuario, id_cargo) VALUES
    ('Agusto Benitze', 'Rua jose alfredo ribas, 1232', 'Estoquista', 1),
    ('Sophia Pimentel Peralta', 'Avenida Brasil, 2541', 'Vendedor', 2),
    ('Alice Assis', 'Rua Antonio Gasparin, 1054', 'Secretario', 3),
    ('Maria Fernanda Taborda ', 'Rua Lavrador, 564', 'Gerente', 4),
    ('Angelo Miguel Pimentel', 'Rua Dino Paolini, 945', 'Diretor', 5);

INSERT INTO empresa (nome_empresa) VALUES
    ('Nestle'),
    ('Font Life'),
    ('Kibon');

SET @idNestle = (SELECT id_empresa FROM empresa WHERE empresa.id_empresa = "Nestle");
SET @idFontLife = (SELECT id_empresa FROM empresa WHERE empresa.id_empresa = "Font Life");
SET @idKibon = (SELECT id_empresa FROM empresa WHERE empresa.id_empresa = "Kibon");

INSERT INTO produtos (nome_produto, preco_compra, preco_venda, quantidade, id_empresa) VALUES
    ('Chocolate Classic', '3,00', '6,99', '587', 1),
    ('Farinha Lactea', '4,50', '9,00', '214', 1),
    ('Nescau', '5,50', '9,00', '600', 1),
    ('Agua', '1,00', '2,50', '365', 2),
    ('Sorvete Snikers', '8,99', '18,00', '758', 3),
    ('Sorvete Tablito', '8,99', '18,00', '812', 3);

SET @idChocolateClassic = (SELECT id_empresa FROM empresa WHERE empresa.id_empresa = "Chocolate Classic");
SET @idFarinhaLactea = (SELECT id_empresa FROM empresa WHERE empresa.id_empresa = "Farinha Lactea");
SET @idNescau = (SELECT id_empresa FROM empresa WHERE empresa.id_empresa = "Nescau");
SET @idAgua = (SELECT id_empresa FROM empresa WHERE empresa.id_empresa = "Agua");
SET @idSorveteSnikers = (SELECT id_empresa FROM empresa WHERE empresa.id_empresa = "Sorvete Snikers");
SET @idSorveteTablito = (SELECT id_empresa FROM empresa WHERE empresa.id_empresa = "Sorvete Tablito");
    
INSERT INTO clientes (nome_cliente, cnpj_cpf, telefone,endereco) VALUES
    ('Luiz Pimentel', '212.343.445-54','(41) 989856654', 'Rua Waldemiro Ry 1011'),
    ('Deusita Correa de Assis', '254.154.875-29', '(41) 998465298','Rua Jose Bettega 2098');

INSERT INTO 
    clientes_produtos (id_cliente, id_produto)
VALUES
     (
        (SELECT id_cliente FROM clientes WHERE clientes.nome_cliente = 'Luiz Pimentel'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Nescau')

    ),
     (
        (SELECT id_cliente FROM clientes WHERE clientes.nome_cliente = 'Luiz Pimentel'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Farinha Lactea')

    ),
     (
        (SELECT id_cliente FROM clientes WHERE clientes.nome_cliente = 'Deusita Correa de Assis'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Chocolate Classic')

    ),
     (
        (SELECT id_cliente FROM clientes WHERE clientes.nome_cliente = 'Deusita Correa de Assis'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Agua')
    ),
     (
        (SELECT id_cliente FROM clientes WHERE clientes.nome_cliente = 'Deusita Correa de Assis'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Sorvete Snikers')

    ),
    (
        (SELECT id_cliente FROM clientes WHERE clientes.nome_cliente = 'Deusita Correa de Assis'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Sorvete Tablito')

    );

    INSERT INTO 
    usuarios_produtos (id_usuario, id_produto)
VALUES
     (
        (SELECT id_usuario FROM usuarios WHERE usuarios.nome_usuario = 'Agusto Benitze'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Nescau')

    ),
     (
        (SELECT id_usuario FROM usuarios WHERE usuarios.nome_usuario = 'Sophia Pimentel Peralta'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Chocolate Classic')

    ),
     (
        (SELECT id_usuario FROM usuarios WHERE usuarios.nome_usuario = 'Alice Assis'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Farinha Lactea')

    ),
     (
        (SELECT id_usuario FROM usuarios WHERE usuarios.nome_usuario = 'Maria Fernanda Taborda'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Agua')

    ),
     (
        (SELECT id_usuario FROM usuarios WHERE usuarios.nome_usuario = 'Angelo Miguel Pimentel'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Sorvete Snikers')

    ),
    (
        (SELECT id_usuario FROM usuarios WHERE usuarios.nome_usuario = 'Alice Assis'),
        (SELECT id_produto FROM produtos WHERE produtos.nome_produto = 'Sorvete Tablito')

    );
    
 
/*-----------------1------------------*/
SELECT ' Com subselect, monte query traz o nome do cliente, a empresa do
cliente, o nome do produto que o cliente consume, o telefone do cliente 
e a quantidade doproduto em estoque. Deve haver um limit de 3 registros.' AS 'Questao 1';

SELECT 
    (SELECT 
        nome_cliente
    FROM 
        clientes  
    WHERE 
        clientes.id_cliente = clientes_produtos.id_cliente) AS nome_cliente,
    (SELECT 
        telefone
    FROM 
        clientes  
    WHERE 
        clientes.id_cliente = clientes_produtos.id_cliente) AS telefone,
    (SELECT 
        nome_produto
    FROM 
        produtos  
    WHERE produtos.id_produto = clientes_produtos.id_produto) AS nome_produto,
    (SELECT 
        quantidade
    FROM 
        produtos  
    WHERE produtos.id_produto = clientes_produtos.id_produto) AS quantidade
    FROM 
        clientes_produtos 
    WHERE
        clientes_produtos.id_produto IN(
            SELECT
                produtos.id_produto
            FROM
                produtos 
            WHERE
                produtos.id_empresa IN(
                    SELECT
                        empresa.id_empresa
                    FROM
                        empresa     
                    )
        );

/*-----------------2------------------*/
SELECT 'Com subselect, monte query traz o nome do cliente, a empresa do cliente,
 o nome do produto que o cliente consume, o telefone do cliente e a quantidade 
 do produto em estoque. Deve haver uma ordenação orientada pela quantidade
  de produtos sendo essa descendente.' AS 'Questao 2';

SELECT 
    (SELECT 
        nome_cliente
    FROM 
        clientes 
    WHERE 
        clientes.id_cliente = clientes_produtos.id_cliente) AS nome_cliente,
    (SELECT 
        telefone
    FROM 
        clientes  
    WHERE 
        clientes.id_cliente = clientes_produtos.id_cliente) AS telefone_cliente,
    (SELECT 
        nome_produto
    FROM 
        produtos 
    WHERE produtos.id_produto = clientes_produtos.id_produto) AS nome_produto,
    (SELECT 
        quantidade
    FROM 
        produtos 
    WHERE produtos.id_produto = clientes_produtos.id_produto) AS quantidade_estoque
    FROM 
        clientes_produtos 
   
    WHERE
        clientes_produtos.id_produto IN(
            SELECT
                produtos.id_produto
            FROM
                produtos 
            WHERE
                produtos.id_empresa IN(
                    SELECT
                        empresa.id_empresa
                    FROM
                        empresa     
                    )
        ) ORDER BY quantidade_estoque DESC;

/*-----------------3------------------*/

SELECT 'Com inner join, monte query traz o nome do cliente, a empresa
 do cliente, o nome do produto que o cliente consume, o telefone do 
 cliente e a quantidade do produto em estoque. Deve haver uma ordenação
  orientada pelo preço de compra (do maior para o menor ' AS 'Questao 3';

SELECT
    clientes.nome_cliente,
    clientes.telefone,
    produtos.nome_produto,
    produtos.quantidade,
    produtos.preco_compra,
    empresa.nome_empresa
FROM
    clientes
INNER JOIN
    clientes_produtos ON clientes.id_cliente=clientes_produtos.id_cliente
INNER JOIN
    produtos ON produtos.id_produto=clientes_produtos.id_produto
INNER JOIN  
    empresa ON empresa.id_empresa=produtos.id_empresa
ORDER BY produtos.preco_compra DESC;

/*-----------------4------------------*/

SELECT 'Com left join, monte query traz o nome do cliente, a empresa do 
cliente, o nome do produto que o cliente consume, o telefone do cliente 
e a quantidade do produto em estoque. Deve haver uma ordenação orientada
 pelo preço de compra (do maior para o menor' AS 'Questao 4';

SELECT
    clientes.nome_cliente,
    clientes.telefone,
    produtos.nome_produto,
    produtos.quantidade,
    produtos.preco_compra,
    empresa.nome_empresa
FROM
    clientes
LEFT JOIN
    clientes_produtos ON clientes.id_cliente=clientes_produtos.id_cliente
INNER JOIN
    produtos ON produtos.id_produto=clientes_produtos.id_produto
INNER JOIN  
    empresa ON empresa.id_empresa=produtos.id_empresa
ORDER BY produtos.preco_compra DESC;