create database tp;
use tp;
create table articles (
  noart int primary key,
  libelle varchar(50),
  stock int,
  prixinvent decimal(10, 2)
);
INSERT INTO articles VALUES 
(10, 'art1', 222, 2500),
(20, 'art2', 333, 300),
(30, 'art3', 444, 450);
create table fournisseurs (
  nofour int primary key,
  nomfour varchar(50),
  adrfour varchar(50),
  villefour varchar(50)
);
INSERT INTO fournisseurs VALUES 
(11, 'four1','four1@gamil.com', 'boujdour'),
(22, 'four2','four2@gamil.com', 'dakhla'),
(33, 'four3','four3@gamil.com', 'essmara');
create table acheter (
  nofour int,
  noart int,
  prixachat decimal(10, 2),
  delai int,
  foreign key (nofour) references fournisseurs(nofour),
  foreign key (noart) references articles(noart),
  primary key (nofour, noart)
);
INSERT INTO acheter VALUES 
(11, 10, 3000, 10),
(22, 20, 350, 9),
(33, 30, 500, 7);



-- Q1:
select noart,libelle from articles where stock<10;

-- Q2:
select * from articles where prixinvent between 100 and 300;

-- Q3:
select * from fournisseurs where adrfour is null;

-- Q4:
select * from fournisseurs where nomfour like 'four%';

-- Q5:
select f.nomfour, f.adrfour from fournisseurs f inner join acheter a on f.nofour = a.nofour where a.delai > 20;

-- Q6:
select count(*) from articles;

-- Q7:
select sum(stock*prixinvent) from articles;

-- Q8:
select noart, libelle from articles order by stock desc;

-- Q9;
-- max
SELECT a.noart, a.libelle, ac.prixachat FROM articles a
INNER JOIN acheter ac ON a.noart = ac.noart where ac.prixachat=(select max(prixachat));
-- min
SELECT a.noart, a.libelle, ac.prixachat FROM articles a
INNER JOIN acheter ac ON a.noart = ac.noart where ac.prixachat=(select min(prixachat));
-- moyenne
select avg(prixachat) as moyenne from acheter;

-- Q10:
SELECT nofour, count(noart), AVG(delai) FROM acheter GROUP BY nofour HAVING COUNT(noart) >= 2;

-- Q11:
select * from acheter where noart=1 and prixachat=(select min(prixachat) from acheter where noart=1);
select * from acheter where noart=2 and prixachat=(select min(prixachat) from acheter where noart=2);

-- Q12:

select a.noart, a.libelle from articles a inner join acheter ac on a.noart = ac.noart inner join fournisseurs f on ac.nofour = f.nofour
where a.noart in (select noart from acheter group by noart having count(distinct nofour) > 1);

-- Q13 
select f.nofour, f.nomfour, count(a.noart) from fournisseurs f inner join acheter a on f.nofour = a.nofour
group by f.nofour, f.nomfour
having count(a.noart) = (select count(noart) from acheter group by nofour order by count(noart) desc limit 1);

call p3(200,300);
