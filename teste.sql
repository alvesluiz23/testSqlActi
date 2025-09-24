CREATE TABLE usuario (
    nome varchar(100) NOT NULL,
    cpf varchar(15) NOT NULL PRIMARY KEY  
    
 )
 
 CREATE TABLE livro (
    nome varchar(100) NOT NULL,
    id INT IDENTITY NOT NULL PRIMARY KEY  
    
 )
  
 CREATE TABLE emprestimo (
    id INT IDENTITY PRIMARY KEY,
    cpf_tomador varchar(15) NOT NULL FOREIGN KEY REFERENCES usuario(cpf),
    livro_id INT   NOT NULL FOREIGN KEY REFERENCES livro(id) ,
    status INT NOT NULL
 )
 
  
CREATE OR ALTER PROCEDURE sp_livro_insert
    @nome VARCHAR(100)
AS
BEGIN
    INSERT INTO livro (nome) VALUES (@nome);
END;

CREATE OR ALTER PROCEDURE sp_usuario_insert
    @nome VARCHAR(100), @cpf VARCHAR(15)
AS
BEGIN
    INSERT INTO usuario (nome, cpf) VALUES (@nome, @cpf);
END;


CREATE OR ALTER PROCEDURE sp_livro_update
    @id INT, @nome VARCHAR(100)
AS
BEGIN
    UPDATE livro SET nome = @nome WHERE id = @id;
END;


CREATE OR ALTER PROCEDURE sp_livro_select @id INT = NULL
 AS
 BEGIN
	 IF @id IS NULL
	 	SELECT * FROM livro
	 ELSE
	    SELECT * FROM livro WHERE id = @id;
 	
 END;
 
CREATE OR ALTER PROCEDURE sp_livro_delete @id INT
 AS
 BEGIN
	 IF EXISTS(SELECT 1 FROM emprestimo WHERE livro_id = @id and status = 1)
	 BEGIN;
	   RAISERROR('O livro está emprestado',16,1);
       RETURN;
      END;
    DELETE livro WHERE livro.id = @id
 	
 END;
 
 CREATE OR ALTER PROCEDURE sp_usuario_select @cpf VARCHAR(15) = NULL
 AS
 BEGIN
	 IF @cpf IS NULL
	 	SELECT * FROM usuario
	 ELSE
	    SELECT * FROM usuario WHERE cpf = @cpf;
 	
 END;
 
 
 CREATE OR ALTER PROCEDURE sp_empresta @id INT = NULL, @cpf VARCHAR(15)
 AS
 BEGIN
	IF NOT EXISTS(SELECT 1 FROM livro WHERE id = @id)
	BEGIN
       RAISERROR('O livro não existe nos registros',16,1);
       RETURN;
     END;
   	IF NOT EXISTS(SELECT 1 FROM usuario WHERE cpf = @cpf)
   	BEGIN
       RAISERROR('Usuario não cadastrado',16,1);
       RETURN;
    END;
    IF EXISTS(SELECT 1 FROM emprestimo WHERE livro_id = @id)
   	BEGIN
       RAISERROR('Livro já emprestado',16,1);
       RETURN;
    END;
    
    INSERT INTO emprestimo (cpf_tomador, livro_id, status) VALUES (@cpf, @id, 1);
 	   
 END;
 
 CREATE OR ALTER PROCEDURE sp_devolve @id INT = NULL
 AS
 BEGIN
	IF NOT EXISTS(SELECT 1 FROM emprestimo WHERE livro_id = @id)
	BEGIN
       RAISERROR('O livro não está emprestado',16,1);
       RETURN;
    END;
 
    DELETE emprestimo WHERE livro_id = @id;
 	   
 END;
 
 
 
 