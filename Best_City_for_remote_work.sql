-- Best City for Remote Work --
create database workstation;
use workstation;
-- Read Data --
select *  from `workation`;

-- 1] List the top 10 countries according to their max average wifi speed --
select  Country , max(Average_Wifi_speed) from `workation` group by Country 
order by max(Average_Wifi_speed) desc limit 10; 

-- 2] Find the top 5 cities having maximum number of tourist attraction --
select City , max(Tourist_attractions) from `workation` group by City 
order by max(Tourist_attractions) desc limit 5;

-- 3] Find count of each country in the top 10 cities having highest average wifi speeds --
select Country , count(Country) , max(Average_WiFi_speed) from `workation` 
group by Country order by max(Average_WiFi_speed) desc limit 10;

-- 4] Which are the cities with an average WiFi Speed grater Than 50 MBPS and an average price of a meal at a local , 
 -- mid-level  restaurant less than 10 (Pounds)? --
 select City from `workation` where Average_WiFi_speed > 50 and 
 Avg_cost_of_a_meal_at_a_local_midlevel_restaurant < 10;
 
 -- 5] In which cities can remote workers enjoy the most affordable accomodation , meal , taxi , coffee and beers?--
 -- Meaning Calculate their overall affordability --
 
 select rank() over(order by Score_1) as rank_1 , city , country from
 (select city , country , round((0.35*Avg_price_of_one_bedroom_apartment_per_month) +
 (0.35*Avg_cost_of_a_meal_at_a_local_midlevel_restaurant) +
 (0.10*Avg_price_of_taxi) +
 (0.10*Avg_price_of_buying_a_coffee) +
 (0.10*Avg_price_for_2beers_in_a_bar),2) as Score_1
 from `workation`) as subquery
 order by Score_1;
 
 -- 6] Do the same question as above but now rank them within their country --
 
 select rank() over(partition by Country order by Score_1) as rank_1 , city , country , Score_1 from
 (select city , country , round((0.35*Avg_price_of_one_bedroom_apartment_per_month) +
 (0.35*Avg_cost_of_a_meal_at_a_local_midlevel_restaurant) +
 (0.10*Avg_price_of_taxi) +
 (0.10*Avg_price_of_buying_a_coffee) +
 (0.10*Avg_price_for_2beers_in_a_bar),2) as Score_1
 from `workation`) as subquery
 order by Country;
 
 -- 7]  Which city offers the best combination of fast wifi , ample co-working spaces, numerous tourist attraction
      -- and pleasant weather for remote workers? --
      select rank() over (order by Score_2 desc) as rank_2 , city , country , Score_2
      from (
      select city , country,
      round((0.40*Average_WiFi_speed) + (0.30*No_of_coworking_spaces) + (0.20*Tourist_attractions)
      +(0.10*Avg_no_of_sunshine_hours),2)as Score_2
      from `workation`
    )  as subquery
      order by Score_2 desc;
      
     -- 8] Do the same question as above but now rank them within their country --
     select rank() over (partition by country order by Score_2 desc) as rank_2 , city , country , Score_2
      from (
      select city , country,
      round((0.40*Average_WiFi_speed) + (0.30*No_of_coworking_spaces) + (0.20*Tourist_attractions)
      +(0.10*Avg_no_of_sunshine_hours),2)as Score_2
      from `workation`
    )  as subquery
      order by country;
      
      -- 9] What is the total number of co-working spaces in the dataset, and what percentage of them are located
           -- in the top 10 cities with the highest number of co-working spaces? --
	select city , round(No_of_coworking_spaces/(select sum(No_of_coworking_spaces) from `workation`)*100,2) as percentage
    from `workation`
    order by No_of_coworking_spaces desc
    limit 10;
    
    -- 10] List the cities which have less than the overall average in average_price_of_one_bedroom_apartment_per_month --
    select city , (Avg_price_of_one_bedroom_apartment_per_month)
    from `workation`
    where
    Avg_price_of_one_bedroom_apartment_per_month <=
    (select round(avg(Avg_price_of_one_bedroom_apartment_per_month),2)from `workation`)
    order by Avg_price_of_one_bedroom_apartment_per_month;
    
    -- 11] Compare the Indian cities on all factors --
    select * from `workation` where country = "India";