 -- Car Dekho Data Analysis--
use Cars;
-- Read Data--
select * from `car dekho_data`;

-- Total Cars :  To get a  count of total records--
select count(*) from `car dekho_data`;

-- The manager asked the employee How many cars will be available in 2023 --
select count(*) from `car dekho_data` where year = 2023;

-- The manager asked the employee How many cars will be available in 2020 , 2021 , 2022 --
select count(*) from `car dekho_data` where year in (2020 , 2021 , 2022); #88
select count(*) from `car dekho_data` where year = 2020; #74
select count(*) from `car dekho_data` where year = 2021; #7
select count(*) from `car dekho_data` where year = 2022; #7
select count(*) from `car dekho_data` where year in (2020 , 2021 ,2022) group by year;

-- Client asked me to print the total of all cars by year --
select year , count(*) from `car dekho_data` group by year;

-- Client asked to car dealer agent How many diesel cars will there be in 2020? --
select count(*) from `car dekho_data` where fuel = "Diesel" and year = '2020';

-- Client requested to car dealer agent How many petrol cars will there be in 2020? --
select count(*) from `car dekho_data` where fuel = "Petrol" and year = '2020';

-- The manager told the employee to give a print all the fuel cars(petrol , diesel and CNG) come by all year --
select year , count(*) from `car dekho_data` where fuel = "Petrol"  group by year;
select year , count(*) from `car dekho_data` where fuel = "Diesel"  group by year;
select year , count(*) from `car dekho_data` where fuel = "CNG"  group by year;

-- Manager said there were more than 100 cars in a given year , which year had more than 100 cars ? --
select year , count(*) from `car dekho_data` group by year having count(*) > 100;
select year , count(*) from `car dekho_data` group by year having count(*) < 50;

-- The manager said to the employee All cars count details between 2015 and 2023 --
select count(*) from `car dekho_data` where year between 2015 and 2023; #4124

-- The manager said to the employee All cars details between 2015 and 2023 --
select *from `car dekho_data` where year between 2015 and 2023;

-- END --