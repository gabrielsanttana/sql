create trigger exclusao_compra
on compra for delete
as
delete item_compra where id_compra = (select id from deleted)
if @@ROWCOUNT > 0
 	commit transaction
else
  rollback transaction
go

create trigger inclusao_item_compra
on item_compra for insert
as 
if not exists (
  select * from inserted i 
  inner join compra c
  on i.id_compra = c.id)
  begin
    print 'Esse item não contém um número de nota válido'
    rollback transaction
  end
else
  begin
    update compra 
    set compra.valor_total = compra.valor_total + (
      select p.preco * i.quantidade from inserted i
      inner join produto p on p.id = i.id_produto) 
      where id = (select id_compra from inserted)
      if @@ROWCOUNT > 0
        begin
          update produto
          set produto.quantidade_estoque = produto.quantidade_estoque - (select i.quantidade from inserted i) 
          where produto.id = (select id_produto from inserted) and produto.quantidade_estoque >= (select i.quantidade from inserted i)
          if @@ROWCOUNT > 0
            commit transaction
          else
            rollback transaction
        end
      else
        rollback transaction
    end
go

create trigger alteracao_item_compra
on item_compra for update
as 
if not exists (
  select * from inserted i 
  inner join compra c
  on i.id_compra = c.id)
  begin
    print 'Esse item não contém um número de nota válido'
    rollback transaction
  end
else
  begin
    update compra 
    set compra.valor_total = compra.valor_total - (
      select p.preco * d.quantidade from deleted d
      inner join produto p on p.id = d.id_produto) 
      where id = (select id_compra from deleted)
    if @@ROWCOUNT > 0
      begin
        update compra 
        set compra.valor_total = compra.valor_total + (
          select p.preco * i.quantidade from inserted i
          inner join produto p on p.id = i.id_produto) 
        where id = (select id_compra from inserted)
        if @@ROWCOUNT > 0
          begin
            update produto
            set produto.quantidade_estoque = produto.quantidade_estoque + (select d.quantidade from deleted d) 
            where produto.id = (select id_produto from deleted)
            if @@ROWCOUNT > 0
              begin
                update produto
                set produto.quantidade_estoque = produto.quantidade_estoque - (select i.quantidade from inserted i) 
                where produto.id = (select id_produto from inserted) and produto.quantidade_estoque >= (select i.quantidade from inserted i)
                if @@ROWCOUNT > 0
                  commit transaction
                else
                  rollback transaction
              end
            else
              rollback transaction
          end
    else
      rollback transaction
  end
    else
      rollback transaction
  end
go

create trigger exclusao_item_compra
on item_compra for delete
as 
update compra 
set compra.valor_total = compra.valor_total - (
  select p.preco * d.quantidade from deleted d
  inner join produto p on p.id = d.id_produto) 
where id = (select id_compra from deleted)
if @@ROWCOUNT > 0
  begin
    update produto
    set produto.quantidade_estoque = produto.quantidade_estoque + (select d.quantidade from deleted d) 
    where produto.id = (select id_produto from deleted)
    if @@ROWCOUNT > 0
      commit transaction
    else
      rollback transaction
    end
else
  rollback transaction
go