create database ass5
use ass5

create table person(
p_id int identity primary key not null,
f_name nvarchar(10) not null,
l_name nvarchar(30) not null,
birth_day date,
city nvarchar(30) not null,
district nvarchar(30) not null,
commue nvarchar(30) not null,
);

create table phone(
ph_id int identity primary key not null,
ph_num varchar(10) not null,
p_id int not null,
foreign key (p_id) references person(p_id)
);

insert into person values('Nguyen','Van An','11/18/87','Ha Noi','Thanh Xuan','Nguyen Trai')
insert into phone values('987654321',1),('09873452',1),('09832323',1),('09434343',1)

--cau 4
select*from person
select*from phone

--cau 5
select*from person order by l_name asc
select ph_num from phone ph join person p on p.p_id =ph.p_id
select birth_day,f_name,l_name from person where birth_day='12/12/09'

-- cau 6
select count(ph_id),p_id from phone group by p_id  

--cau7
update person 
set birth_day=DATEADD(day,-1,birth_day) where p_id in (select p_id from person)
exec sp_pkeys 'person'
exec sp_fkeys 'person'

--cau 8
create proc newCont(@phone varchar(10),@f_name nvarchar(10),@l_name nvarchar(30),@birth_day date,@city nvarchar(30),@district nvarchar(30),@commue nvarchar(30)) as
begin
if (not exists (select ph_num from phone where ph_num=@phone)) 
begin
insert into person values (@f_name,@l_name,@birth_day,@city,@district,@commue)
select p_id newp from person where f_name=@f_name and l_name=@l_name and birth_day=@birth_day and city=@city and district=@district and commue=@commue;
insert into phone(ph_num) value (@phone);
update phone set p_id= person
end