create procedure cadastrar_fornecedor_e_endereco
@email char(30),
@cnpj char(18),
@razao_social char(50),
@nome_fantasia char(50),
@rua char(40),
@numero int,
@bairro char(40),
@cidade char(40),
@estado char(2),
@id_endereco int = NULL,
@id_pessoa int = NULL OUTPUT
as 
begin transaction
  insert into endereco(rua, numero, bairro, cidade, estado)
  values (@rua, @numero, @bairro, @cidade, @estado);
  set @id_endereco = SCOPE_IDENTITY()
  if @@rowcount > 0 -- Operacao realizada com sucesso
    begin
	  insert into pessoa(email, id_endereco)
	  values(@email, @id_endereco)
	  set @id_pessoa = SCOPE_IDENTITY()
      if @@rowcount > 0 -- Operacao realizada com sucesso
	    begin
		  insert into fornecedor(id_pessoa, cnpj, razao_social, nome_fantasia)
		  values(@id_pessoa, @cnpj, @razao_social, @nome_fantasia)
          if @@rowcount > 0 -- Operacao realizada com sucesso
		    begin
	          commit transaction
	          return 1
	  	    end
		  else
		    begin
	          rollback transaction
	          return 0
		    end
	    end
	  else
	    begin
	      rollback transaction
	      return 0
		end
	end
  else
    begin
	  rollback transaction
	  return 0
	end

create procedure cadastrar_fornecedor_produto
@id_fornecedor int,
@id_produto int
as
insert into fornecedor_produto(id_fornecedor, id_produto)
values (@id_fornecedor, @id_produto);

create procedure cadastrar_produto
@nome char(50),
@volume real,
@id_unidade_medida int,
@id_categoria int,
@preco money,
@quantidade_estoque int,
@codigo_barra char(13)
as
insert into produto(nome, volume, id_unidade_medida, id_categoria, preco, quantidade_estoque, codigo_barra)
values(@nome, @volume, @id_unidade_medida, @id_categoria, @preco, @quantidade_estoque, @codigo_barra);

create procedure cadastrar_compra
@data_compra datetime,
@id_cliente int,
@id_produto int,
@quantidade int,
@id_compra int = NULL
as
begin transaction
  insert into compra(valor_total, data_compra, id_cliente)
  values(0, @data_compra, @id_cliente)
  set @id_compra = SCOPE_IDENTITY()
  if @@ROWCOUNT > 0
    begin
      insert into item_compra(id_compra, id_produto, quantidade)
    values (@id_compra, @id_produto, @quantidade)
    if @@ROWCOUNT > 0
      begin
        commit transaction
      return 1
        end
    else
      begin
          rollback transaction
        return 0
      end
    end
  else
    begin
      rollback transaction
    return 0
    end
go

create procedure cadastrar_item_compra
@id_compra int,
@id_produto int,
@quantidade int
as
  insert into item_compra(id_compra, id_produto, quantidade)
  values (@id_compra, @id_produto, @quantidade)
go

create procedure cadastrar_item_compra
@id_compra int,
@id_produto int,
@quantidade int
as
insert into item_compra(id_compra, id_produto, quantidade)
values (@id_compra, @id_produto, @quantidade)
go

create procedure cadastrar_categoria
@nome char(30),
@descricao varchar(100)
as
insert into categoria(nome, descricao)
values (@nome, @descricao)
go

create procedure cadastrar_unidade_medida
@nome char(60),
@abreviacao char(10)
as
insert into unidade_medida(nome, abreviacao)
values (@nome, @abreviacao)
go

create procedure cadastrar_cargo
@titulo char(30),
@descricao varchar(100)
as
insert into cargo(titulo, descricao)
values (@titulo, @descricao)
go

create procedure cadastrar_cliente_e_endereco
@email char(30),
@nome char(50),
@cpf char(11),
@rg char(9),
@data_nascimento date,
@rua char(40),
@numero int,
@bairro char(40),
@cidade char(40),
@estado char(2),
@id_endereco int = NULL,
@id_pessoa int = NULL OUTPUT
as 
begin transaction
  insert into endereco(rua, numero, bairro, cidade, estado)
  values (@rua, @numero, @bairro, @cidade, @estado);
  set @id_endereco = SCOPE_IDENTITY()
  if @@rowcount > 0 -- Operacao realizada com sucesso
    begin
      insert into pessoa(email, id_endereco)
      values (@email, @id_endereco)
	  set @id_pessoa = SCOPE_IDENTITY()
      if @@rowcount > 0 -- Operacao realizada com sucesso
        begin  
          insert into pessoa_fisica(id_pessoa, cpf, nome)
          values(@id_pessoa, @cpf, @nome)
          if @@rowcount > 0 -- Operacao realizada com sucesso
            begin
              insert into cliente(id_pessoa, rg, data_nascimento)
              values(@id_pessoa, @rg, @data_nascimento)
              if @@rowcount > 0 -- Operacao realizada com sucesso
                begin
                  commit transaction
                  return 1
                end
              else
                begin
                  rollback transaction
                  return 0
                end
            end
          else
            rollback transaction
            return 0
        end
      else
        rollback transaction
        return 0
    end
  else
    rollback transaction
    return 0
go

create procedure cadastrar_funcionario_e_endereco
@email char(30),
@nome char(50),
@cpf char(11),
@id_cargo int,
@salario money,
@carteira_trabalho char(11),
@rua char(40),
@numero int,
@bairro char(40),
@cidade char(40),
@estado char(2),
@id_endereco int = NULL,
@id_pessoa int = NULL OUTPUT
as 
begin transaction
  insert into endereco(rua, numero, bairro, cidade, estado)
  values (@rua, @numero, @bairro, @cidade, @estado);
  set @id_endereco = SCOPE_IDENTITY()
  if @@rowcount > 0 -- Operacao realizada com sucesso
    begin
      insert into pessoa(email, id_endereco)
      values (@email, @id_endereco)
	  set @id_pessoa = SCOPE_IDENTITY()
      if @@rowcount > 0 -- Operacao realizada com sucesso
        begin  
          insert into pessoa_fisica(id_pessoa, cpf, nome)
          values(@id_pessoa, @cpf, @nome)
          if @@rowcount > 0 -- Operacao realizada com sucesso
            begin
              insert into funcionario(id_pessoa, id_cargo, salario, carteira_trabalho)
              values(@id_pessoa, @id_cargo, @salario, @carteira_trabalho)
              if @@rowcount > 0 -- Operacao realizada com sucesso
                begin
                  commit transaction
                  return 1
                end
              else
                begin
                  rollback transaction
                  return 0
                end
            end
          else
            rollback transaction
            return 0
        end
      else
        rollback transaction
        return 0
    end
  else
    rollback transaction
    return 0
go	

create procedure cadastrar_funcionario_como_cliente
@id_pessoa int,
@rg char(9),
@data_nascimento date
as 
insert into cliente(id_pessoa, rg, data_nascimento)
values (@id_pessoa, @rg, @data_nascimento)
go
	  
create procedure cadastrar_cliente_como_funcionario
@id_pessoa int,
@id_cargo int,
@salario money,
@carteira_trabalho char(11)
as 
insert into funcionario(id_pessoa, id_cargo, salario, carteira_trabalho)
values (@id_pessoa, @id_cargo, @salario, @carteira_trabalho)
go

/*
declare @id_pessoa int;
exec cadastrar_cliente_e_endereco
@email = 'gabriel@gmail.com',
@nome = 'gabriel a',
@cpf = '14785236951',
@rg = '514512548',
@data_nascimento = '10-05-1999',
@rua = 'Rua São Vicente',
@numero = 152,
@bairro = 'Jardim das Copas',
@cidade = 'Campo Belo',
@estado = 'MG',
@id_pessoa =  @id_pessoa OUTPUT;
print @id_pessoa
*/