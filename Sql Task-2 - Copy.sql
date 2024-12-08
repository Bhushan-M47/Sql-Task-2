--Joins 
select customer_name, city, order_date from customers c 
join orders o on c.customer_id=o.customer_id where extract(year from o.order_date) = '2023';

select product_name, category, total_price from customers c
join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id=oi.order_id
join products p on p.product_id= oi.product_id 
where city='Mumbai';

select customer_name, order_date, total_price from customers c
join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id=oi.order_id
where payment_mode='Credit Card';

select product_name, category, total_price from products p
join order_items oi on p.product_id=oi.product_id
join orders o on o.order_id=oi.order_id 
where order_date between '2023-01-01' and '2023-06-30';

select customer_name, sum(oi.quantity) products_ordered from customers c
join orders o on c.customer_id=o.customer_id
join order_items oi on o.order_id=oi.order_id group by customer_name;


--Distinct 
select distinct city from customers

select distinct supplier_name from products

select distinct payment_mode from orders

select distinct category from products 

select distinct supplier_city from products

--order by 
select * from customers order by customer_name;

select * from order_items order by total_price desc;

select * from products order by price,category desc;

select order_id,customer_id,order_date from orders order by order_date desc;

select city,count(order_id) from customers c join orders o on c.customer_id=o.customer_id  group by city order by city;

--Limit & Offset 
select customer_name from customers order by customer_name limit 10;

select * from products order by price desc limit 5;

select * from customers order by customer_id offset 10 limit 10;

select order_id, order_date, customer_id from orders where extract(year from order_date)='2023' limit 5;

select distinct city from customers limit 10 offset 10; 

--Aggregate Functions
select count(customer_id),customer_name from customers group by customer_name;

select sum(order_amount) from orders where payment_mode='UPI';

select avg(price) from products;

select max(total_price),min(total_price) from order_items oi 
join orders o on o.order_id=oi.order_id where extract(year from order_date)='2023';

select product_id,count(quantity) from order_items group by product_id;

--set operations 
--Task1
select customer_name from customers c join orders o on c.customer_id=o.customer_id where extract(year from order_date)='2022'

intersect

select customer_name from customers c join orders o on c.customer_id=o.customer_id where extract(year from order_date)='2023'

--Task2
select product_name from products where product_id in (select product_id from orders o
join order_items oi on o.order_id=oi.order_id
where extract(year from order_date)='2022')

except

select product_name from products where product_id in (select product_id from orders o
join order_items oi on o.order_id=oi.order_id
where extract(year from order_date)='2023')

--Task3
select supplier_city from products 

except 

select city from customers;

--Task4
select supplier_city from products 

union 

select city from customers;

--Task5 
select product_name from products where product_id in (select product_id from products 
intersect 
select product_id from order_items oi join orders o on oi.order_id=o.order_id where extract(year from order_date)='2023');


--Subqueries 
--Task1
select customer_name from customers where customer_id in (select customer_id from order_items oi 
join orders o on o.order_id=oi.order_id 
group by customer_id having sum(total_price)>(select avg(total_price) from order_items))

--Task2
select product_name from products where product_id in(select product_id from order_items 
group by product_id
having count(*)>1
)

--Task3
select product_name from products where product_id in(select c.customer_id from customers c
join orders o on c.customer_id=o.customer_id where c.city='Pune')

--Task4
select * from orders where order_id in(select order_id from order_items group by order_id
order by sum(total_price) limit '3');

--Task 5
select customer_name from customers where customer_id in(select c.customer_id from customers c 
join orders o on c.customer_id=o.customer_id 
join order_items oi on oi.order_id=o.order_id
where oi.total_price>30000);
