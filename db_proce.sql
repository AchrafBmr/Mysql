create database db_proce;
use db_proce;
create table etudiant(
id int primary key auto_increment,
nom_complet varchar(50),
age int,
moyenne float
);
insert into etudiant values
('','rami ahmed',21,15.5),
('','alaoui khalid',16,18),
('','ait salah',19,17),
('','jalaoui fatima',18,9.5);
select * from etudiant;

-- Q1:
delimiter //
create procedure affi_moy(in id_et int)
begin
select nom_complet,moyenne from etudiant ;
end //
call affi_moy(2);

-- Q2:
delimiter //
create procedure p2(in id_etd int)
begin
select nom_complet,moyenne from etudiant where id=id_etd ;
end //
call p2(3);

-- Q3:
delimiter //
create procedure p3(out nb int)
begin
select count(*) into nb from etudiant where moyenne>=10 ;
end //
call p3(@cpt);
select @cpt as nombre_etd;

-- Q4:
delimiter //
create procedure p4(out nb int)
begin
select count(*) into nb from etudiant ;
end //
call p4(@cpt);
select @cpt as nombre_etd;

-- Q5:
delimiter //
create procedure p5(in n1 int , in n2 int, out somme int)
begin
set somme :=n1+n2;
end //
call p5(2,5,@s);
select @s as somme;

-- Q6:
delimiter //
create procedure p6(inout montant float , in gain float)
begin
set montant :=montant+gain;
end //
set @m=5000;
call p6(@m,500);
select @m as total;

-- Q7:
set @max_age=(select max(age) from etudiant);
select * from etudiant where age=@max_age;


-- Q8:
delimiter //
create procedure conditiion(in nb int)
begin
  if nb>0 then
     set nb=nb+1;
     select nb;
  else set nb=nb-1;
     select nb;
 end if;
end //
call conditiion(-3);


-- Q8:
delimiter //
create procedure moyy(in moy float)
begin
  if moy>=10 then
     select 'admis' as 'result';
  elseif moy>=8 and moy<10 then
     select 'ratt' as 'result';
  else 
    select 'non admis' as 'result';
     
 end if;
end //
call moyy(10);


-- cases:
delimiter //
create procedure cases(in mois int)
begin
case mois
when 10 then select 'october' as 'mois';
when 11 then select 'nove' as 'mois';
when 12 then select 'dece' as 'mois';
else select 'inconnu'as 'mois';
 end case;
end //
call cases(12);


-- les boucles:
delimiter //
create procedure ploop()
begin
   declare a int default 0;
   simple_loop:loop
      set a=a+1;
      select a;
      if a=6 then
        leave simple_loop;
      end if;
   end loop simple_loop;
end //
call ploop(12);



delimiter //
create procedure calcul4(in n int)
begin
   declare i int default 1;
   declare somme int default 0;
   simple_loop:loop
      set somme=somme+i;
      select somme;
      if i=n then
        leave simple_loop;
      end if;
      set i=i+1;
	end loop simple_loop;
 end //
call calcul4(6);



delimiter //
create procedure calcul7(in n int)
begin
   declare i int default n;
   declare somme int default 0;
   simple_loop:loop
      set somme=somme+(i*n);
      select somme;
      if i=0 then
        leave simple_loop;
      end if;
      set i=i-1;
	end loop simple_loop;
 end //
call calcul7(3);


delimiter //
create procedure P_lp()
begin
declare i int;
set i=0;
loop1:loop
set i =i+1;
if i>=10 then
    leave loop1;
elseif mod(i,2)=0 then
     iterate loop1;
end if;
select i;
end loop loop1;
end //



delimiter //
create procedure do_while()
begin
    declare var int default 4;
    while var>0 do
    set var=var-1;
    end while;
    select var;
end //
call do_while();



-- Exercice:
delimiter //
create procedure ex_do_while3(in nb int)
begin
    declare i int default 1;
    declare somme int default 0;
   while i < nb do
        if mod(nb,i) = 0 then
            set somme = somme + i;
        end if;
        set i = i + 1;
    end while;

    if somme = nb then
        select 'parfait' as result;
    else
        select 'non parfait' as result;
    end if;
end //
call ex_do_while3(10);


-- do_repete:
delimiter //
create procedure do_repeat(p1 int)
begin
declare i int default 0;
repeat
set i=i+1;
until i>p1
end repeat;
select i;
end //

call do_repeat()