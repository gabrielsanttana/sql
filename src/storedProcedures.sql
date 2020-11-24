create procedure cadastrar_cliente
@codigo numeric(6,0),
@nome char(40),
@endereco varchar(40),
@telefone numeric(12,0),
@rg char(10),
@dtnasc datetime
as 
begin transaction
  insert into pessoa
  values (@codigo, @nome, @endereco, @telefone)
  if @@rowcount > 0 /*Operacao realizada com sucesso*/
    begin  
      insert into cliente
      values(@codigo, @rg, @dtnasc)
      if @@rowcount > 0 /*Operacao realizada com sucesso*/
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

create procedure cadastrar_atendente
@codigo numeric(6,0),
@nome char(40),
@endereco varchar(40),
@telefone numeric(12,0),
@salario numeric(7,2),
@comissao numeric(3,1)
as 
begin transaction
  insert into pessoa
  values (@codigo, @nome, @endereco, @telefone)
  if @@rowcount > 0 /*Operacao realizada com sucesso*/
    begin  
      insert into atendente
      values(@codigo, @salario, @comissao)
      if @@rowcount > 0 /*Operacao realizada com sucesso*/
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

create procedure cadastrar_item_venda
@codigo_venda numeric(6,0),
@cod_livro numeric(6,0),
@quantidade numeric(3,0)
as
begin transaction
  insert into itemvenda 
  values (@codigo_venda,@cod_livro,@quantidade)
  if @@rowcount > 0 /*Operacao efetuada com sucesso*/
    begin
      update livro 
      set qtd_estoque = qtd_estoque - @quantidade
      where codigo = @cod_livro
      if @@rowcount > 0 /*Operacao efetuada com sucesso*/
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
