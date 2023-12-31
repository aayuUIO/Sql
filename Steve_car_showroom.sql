-- Steve Car ShowRoom Analysis --
create database Steve_Car_Showroom;
use  Steve_Car_Showroom;
create table cars
(
car_id int not null primary key auto_increment,
make varchar(100),
type varchar(50),
style varchar(80),
cost_$ int not null
);

insert into cars ( car_id , make , type , style , cost_$)
values 
( 1 , 'Honda' , 'Civic' ,     'Sedan', 30000),
( 2 ,'Toyota' , 'Corolla' ,    'Hatchback', 25000),
( 3 ,'Ford' , 'Explorer' ,      'SUV', 40000),
(4, 'Chevrolet' , 'Camaro' , 'Coupe', 36000),
( 5 ,'BMW' , 'X5' ,        'SUV', 55000),
(6, 'Audi' , 'A4' ,      'Sedan', 48000),
( 7,'Mercedes' , 'C-Class' , 'Coupe', 60000),
( 8,'Nissan' , 'Altima' ,    'Sedan', 25000);

select * from cars;

create table salesperson
(
salesman_id int not null primary key,
name varchar(80),
age int ,
city varchar(60)
); 

insert into salesperson (salesman_id , name , age , city)
values
( 1 , 'John Smith' , 28 , 'New York'),
( 2 , 'Emily Wong' , 35 , 'San Fran'),
( 3 , 'Tom Lee' , 42 , 'Seattle'),
( 4 , 'Lucy Chen' , 31 , 'LA');

select * from salesperson;

create table sales
(
sale_id int not null primary key,
car_id int not null ,
salesman_id int not null ,
purchase_date date
);

insert into sales (sale_id , car_id , salesman_id , purchase_date)
values
( 1 , 1 , 1 , '2021-01-01'),
( 2 , 3 , 3, '2021-02-03'),
( 3 , 2 , 2 , '2021-02-10'),
( 4 , 5 , 4 , '2021-03-01'),
( 5 , 8 , 1 , '2021-04-02'),
( 6 , 2 , 1 , '2021-05-05'),
( 7 , 4 , 2 , '2021-06-07'),
( 8 , 5 , 3 , '2021-07-09'),
( 9 , 2 , 4 , '2022-01-01'),
( 10 , 1 , 3 , '2022-02-03'),
( 11, 8 , 2 , '2022-02-01'),
( 12, 7 , 2 , '2022-03-01'),
( 13, 5, 3 , '2022-04-02'),
( 14, 3 , 1 , '2022-05-05'),
( 15, 5 , 4 , '2022-06-07'),
( 16 , 1 , 2 , '2022-07-09'),
( 17, 2 , 3 , '2023-01-01'),
( 18, 6 , 3 , '2023-02-03'),
( 19, 7, 1 , '2023-02-10'),
( 20 , 4 , 4 , '2023-03-01');

select *  from sales;

-- 1] What are the details of all cars purchased in the year 2022 ? --
select c.car_id , c.make , c.type , c.style , c.cost_$ , s.car_id from cars c  join sales s 
on c.car_id = s.car_id where extract(year from s.purchase_date) = 2022;

-- 2] What is the total no. of cars sold by each salesperson ?--
select count(c.car_id) as total_no_of_cars  , sp.name from cars c join sales s on c.car_id = s.car_id
join salesperson sp on sp.salesman_id = s.salesman_id group by sp.name;

-- 3] What is the total revenue generated by each salesperson ? --
select sum(c.cost_$) as total_revenue , sp.salesman_id , sp.name from salesperson sp left join sales s
on sp.salesman_id = s.salesman_id 
left join cars c
on c.car_id = s.car_id 
group by sp.salesman_id ,sp.name
order by total_revenue desc;

-- 4] What are the details of the cars sold by each salesperson ? --
select c.car_id , c.make , c.type , c.style , c.cost_$ , sp.salesman_id , sp.name from cars c join sales s 
on c.car_id = s.car_id 
join salesperson sp
on sp.salesman_id = s.salesman_id
order by sp.salesman_id;

-- 5] What is the total revenue generated by each car type ? --
select sum(c.cost_$) as total_revenue , c.type from cars c group by c.type;
select c.car_id , sum(c.cost_$) as total_revenue , c.type from cars c
left join sales s on c.car_id = s.car_id 
group by c.car_id , c.type
order by total_revenue desc;

-- 6] What are the details of the cars sold in the year 2021 by salesperson 'Emily Wong' ? --
select c.car_id , c.make , c.type , c.style , c.cost_$ , sp.name , s.salesman_id from cars c join sales s on
c.car_id = s.car_id
join salesperson sp on
sp.salesman_id = s.salesman_id
where extract(year from s.purchase_date) = 2021 and sp.name = 'Emily Wong';

-- 7] What is the total revenue generated by the sales of hatchback cars ? --
select sum(c.cost_$) as total_revenue , c.car_id  , c.style , s.car_id  from cars c join sales s on c.car_id = s.car_id
where c.style = 'hatchback' group by s.car_id; 

-- 8] What is the total revenue generated by the sales of SUV cars in the year 2022 ? --
select sum(c.cost_$) as total_revenue , c.style  from cars c join sales s 
on c.car_id = s.car_id 
where extract(year from s.purchase_date) = 2022 and c.style = 'SUV' group by c.style;

-- 9] What is the name and city of the salesperson who sold the most number of cars in the year 2023 ? --
select sp.name , sp.city , count(s.car_id) as number_of_cars , sp.salesman_id from cars c
join sales s on c.car_id = s.car_id 
join salesperson sp on s.salesman_id = sp.salesman_id
where extract(year from s.purchase_date) = 2023
group by sp.name ,sp.salesman_id
order by number_of_cars desc
limit 1;


-- 10] What is the name and age  of the salesperson who generated the highest revenue in the year 2022 ? --
select sp.name , sp.age , sum(c.cost_$) as highest_revenue , sp.salesman_id from cars c
join sales s on c.car_id = s.car_id 
join salesperson sp on s.salesman_id = sp.salesman_id
where extract(year from s.purchase_date) = 2022
group by sp.name ,sp.salesman_id
order by highest_revenue desc
limit 1;

