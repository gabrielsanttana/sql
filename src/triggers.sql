create table faturapaga (
  numfatura int not null,
  dtvencimento datetime not null,
  dtpagamento datetime null,
  valor numeric(5,2) not null,
  numnota numeric(10,0) not null,
  primary key (numfatura),
  foreign key (numnota) references notafiscal
)
go

create index ixfaturapaga_notafiscal 
on faturapaga(numnota)
go

-- a)
create trigger inclusaoitemnota 
on itemnotafiscal for insert
as
begin 
  update produto 
  set qtdestoque = 
  qtdestoque - 
  (select i.quantidade
  from inserted i)
  where codproduto = 
  (select i.codproduto
  from inserted i)
  if @@rowcount > 0
    begin
      update notafiscal
      set valortotal =
      valortotal + 
      (select p.preco * i.quantidade as valorproduto
      from inserted i
      inner join produto p
      on p.codproduto = i.codproduto)
      where numnota = (select numnota from inserted)
      if @@rowcount > 0
        commit transaction
      else
        rollback transaction
    end
  else
    rollback transaction
end

-- b)
create trigger exclusaoitemnota
on itemnotafiscal for delete
as
begin 
  update produto 
  set qtdestoque = 
  qtdestoque + 
  (select i.quantidade
  from deleted i)
  where codproduto = 
  (select i.codproduto
  from deleted i)
  if @@rowcount > 0
    begin
      update notafiscal
      set valortotal =
      valortotal - 
      (select p.preco * i.quantidade as valorproduto
      from deleted i
      inner join produto p
      on p.codproduto = i.codproduto)
      where numnota = (select numnota from deleted)
      if @@rowcount > 0
        commit transaction
      else
        rollback transaction
    end
  else
    rollback transaction
end

-- c)
create trigger alteracaoitemnota
on itemnotafiscal for update
as
if update(quantidade) 
begin 
  update produto 
  set qtdestoque = 
  qtdestoque - 
  (select i.quantidade
  from inserted i) +
  (select deleted.quantidade
  from deleted) 
  where codproduto = 
  (select i.codproduto
  from inserted i)
  if @@rowcount > 0
    begin
      update notafiscal
      set valortotal =
      valortotal + 
      (select p.preco * i.quantidade as valorproduto
      from inserted i
      inner join produto p
      on p.codproduto = i.codproduto) -
      (select p.preco * deleted.quantidade as valorproduto
      from deleted
      inner join produto p
      on p.codproduto = deleted.codproduto)
      where numnota = (select numnota from inserted)
      if @@rowcount > 0
        commit transaction
      else
        rollback transaction
    end
  else
    rollback transaction
end

-- d)
create trigger alteracaofatura
on fatura for update
as
if update(dtpagamento)
  begin 
    delete from fatura 
    where numfatura = 
    (select numfatura from inserted)
    if @@rowcount > 0
	  begin
		insert into faturapaga
		select * from inserted
		if @@rowcount > 0
		  commit transaction
		else 
		  rollback transaction
	  end
    else
      rollback transaction
  end