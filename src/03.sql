create table produto (
  codproduto int not null,
  nome char(50) not null,
  preco money not null,
  qtdestoque int not null,
  primary key(codproduto)
)
go

create table notafiscal (
  numnota int not null,
  valortotal money not null,
  primary key(numnota)
)
go

create table itemnotafiscal (
  numnota int not null,
  codproduto int not null,
  quantidade smallint not null,
  primary key(numnota, codproduto),
  foreign key(numnota) references notafiscal,
  foreign key(codproduto) references produto
)
go

create table fatura (
  numfatura int not null,
  dtvencimento date not null,
  dtpagamento date null,
  valor money not null,
  numnota int not null,
  primary key(numfatura),
  foreign key(numnota) references notafiscal
)
go

create index ix_itemnotafiscal_numnota 
on itemnotafiscal (numnota)
go

create index ix_itemnotafiscal_codproduto
on itemnotafiscal (codproduto)
go

create index ix_fatura_numnota 
on fatura (numnota)
go

--2

--a)
create view produtonuncavendidos
as 
select p.codproduto, p.nome, p.qtdestoque from produto p
left join itemnotafiscal inf
on inf.codproduto = p.codproduto
where inf.codproduto is null
go

--b)
create view quantidadeprodutosvendidos
as
select p.codproduto, p.nome, sum(inf.quantidade) from produto p
left join itemnotafiscal inf
on inf.codproduto = p.codproduto
group by p.codproduto, p.nome
order by codproduto
go

--c)
create view notasfaturas
as
select n.numnota, n.valortotal, p.nome, p.preco, inf.quantidade, (p.preco * inf.quantidade) as valorvendido from notafiscal n
inner join itemnotafiscal inf
on inf.numnota = n.numnota
inner join produto p
on p.codproduto = inf.codproduto
order by numnota
go

--d)
create view notasdefaturasaindanaopagas
as
select nf.numnota, nf.valortotal, f.numfatura, f.dtvencimento, f.valor from notafiscal nf
inner join fatura f
on f.numnota = nf.numnota
where f.dtpagamento is null
go

--e)
create view notasdefaturaspagas
as
select nf.numnota, nf.valortotal from notafiscal nf 
where nf.numnota not in (select numnota from fatura where dtpagamento is null)
go