-- Pizza Data Analysis --
SELECT * FROM pizza.`pizza_sales excel file csv`;
use pizza;

-- 1] The sum of the total price of all pizza orders --
select sum(total_price) from `pizza_sales excel file csv`;

-- 2] Average amount per order --
select sum(total_price) / count(distinct order_id) as Avg_Order_Value from `pizza_sales excel file csv`;

-- 3]The sum of the quantities of all pizzas sold -- 
select sum(quantity) from `pizza_sales excel file csv`;

-- 4] The total number of orders placed --
select count(distinct order_id) as Total_orders from `pizza_sales excel file csv`;

-- 5] Average number of pizzas sold per order --
select sum(quantity) / count(distinct order_id) as Avg_quantity_sold from `pizza_sales excel file csv`;


select cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) as Avg_pizzas_per_order from `pizza_sales excel file csv`;

-- 6] Daily Trend for Total Orders --
select datename(DW , order_date) as order_day , count(distinct order_id) as Total_orders 
from `pizza_sales excel file csv` group by datename(DW , order_date);

-- 7] Hourly Trend for Total Orders -- 
select DATEPART(HOUR , order_time) as order_hours , count(distinct order_id) as Total_orders 
from `pizza_sales excel file csv` group by DATEPART(HOUR, order_time) order by DATEPART(HOUR, order_time);

-- 8] Percentage of Sales by Pizza Category--
select pizza_category , sum(total_price) as Total_Sales , 
sum(total_price)*100/ (select sum(total_price) from `pizza_sales excel file csv`) as
Percentage_of_Sales from  `pizza_sales excel file csv` group by pizza_category;


select pizza_category , sum(total_price) as Total_Sales , 
sum(total_price)*100/ (select sum(total_price) from `pizza_sales excel file csv`where month(order_date) = 2) as
Percentage_of_Sales from  `pizza_sales excel file csv` 
where month(order_date) = 2 group by pizza_category;

-- 9] Percentage of Sales by Pizza Size--
select pizza_size , sum(total_price) as Total_Sales , 
sum(total_price)*100/ (select sum(total_price) from `pizza_sales excel file csv`) as
Percentage_of_Sales from  `pizza_sales excel file csv` group by pizza_size;

-- 10] Total Pizzas Sold by pizza category --
select pizza_category , sum(quantity) as Total_Pizzas_Sold from `pizza_sales excel file csv` group by pizza_category;

-- 11] Bottom 5 worst sellers by Total Pizzas Sold --
select  pizza_name , sum(quantity) as Total_Pizzas_Sold from `pizza_sales excel file csv`
group by pizza_name 
order by Total_Pizzas_Sold desc limit 5;

-- 12] Top 5 best sellers by Total Pizzas Sold --
select  pizza_name , sum(quantity) as Total_Pizzas_Sold from `pizza_sales excel file csv`
group by pizza_name 
order by Total_Pizzas_Sold asc limit 5;

-- 13] Top 5 best sellers by Pizza Name --
select  pizza_name , sum(quantity) as Total_Pizzas_Sold from `pizza_sales excel file csv`
where month(order_date) =1
group by pizza_name 
order by Total_Pizzas_Sold asc limit 5;