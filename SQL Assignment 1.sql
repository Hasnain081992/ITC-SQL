# What is the total amount each customer spent at the restaurant
select s.customer_id, sum(m.price) as amount from sales s 
join menu m 
on s.product_id = m.product_id

group by customer_id
order by customer_id
# 2nd que  How many days has each customer visited the restaurant?
select customer_id,count(distinct order_date ) as order_date from sales
group by customer_id
order by customer_id

What was the first item from the menu purchased by each customer?

select customer_id,order_date,product_name  from sales 
join menu 
on sales.product_id = menu.product_id
where order_date = '2021-01-01'

What is the most purchased item on the menu and how many times was it purchased by all customers?

select m.product_name,count(s.order_date) as orderno  from sales s 
join menu m
on m.product_id = s.product_id
group by product_name
order by orderno desc
limit 1;

Which item was the most popular for each customer?

select s.customer_id,m.product_name, count(m.product_name) as totalno from sales s
join menu m
on s.product_id = m.product_id
group by product_name,customer_id
order by totalno
desc;

Which item was purchased first by the customer after they became a member?

select s.customer_id,m.product_name , s.order_date from sales s
join menu  m
on s.product_id = m.product_id
where s.customer_id = 'A' and s.order_date > '2021-01-07'
order by order_date
limit 1

select s.customer_id,m.product_name , s.order_date from sales s
join menu  m
on s.product_id = m.product_id
where s.customer_id = 'B' and s.order_date > '2021-01-09'
order by order_date
limit 1


Which item was purchased just before the customer became a member?
select s.customer_id,m.product_name,s.order_date from sales s
join menu m
on s.product_id = m.product_id
where s.customer_id = 'A' and s.order_date < '2021-01-07'
order by order_date
limit 1

select s.customer_id,m.product_name,s.order_date from sales s
join menu m
on s.product_id = m.product_id
where s.customer_id = 'B' and s.order_date < '2021-01-09'
order by order_date
limit 1


What is the total items and amount spent for each member before they became a member?

select s.customer_id,  count(m.product_name) as totalitem, sum(m.price) as amountspent from 
sales s
join menu m
on s.product_id = m.product_id
join members mem
on mem.customer_id = s.customer_id
where s.order_date < mem.join_date
group by customer_id


If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have


select customer_id,sum(tprice) 
from 
(
select customer_id, case 
when m.product_name = 'sushi' then m.price*20
else
m.price*10 
end 
as tprice
from sales s
join menu m
on s.product_id = m.product_id
)
as total_points 

group by customer_id
order by customer_id


In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?


select customer_id,sum(points) from
(
select s.customer_id ,
case when m.product_name in('sushi','curry','ramen') and s.order_date > mem.join_date then m.price* 2
else m.price*1
end as points
from sales s 
join menu m
on s.product_id = m.product_id
join members mem
on s.customer_id = mem.customer_id
where month(s.order_date) = 1 and (s.customer_id = 'A' or s.customer_id = 'B')

) as totalpoints
group by customer_id
order by customer_id





















