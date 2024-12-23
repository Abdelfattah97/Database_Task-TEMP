-- daily report of the total revenue for a specific date.

-- select  round(sum(oi.unit_price*oi.quantity)::decimal,2)as total_revenue,order_date as date
-- from order_item as oi left join "order" as o on o.order_id = oi.order_fk
-- where o.order_date = '2024-07-23'
-- group by o.order_date
-- order by total_revenue desc;


--Total Revenue for specific date as a function 
CREATE OR REPLACE FUNCTION total_revenue_by_date(report_date date) returns table (total_revenue numeric , date date)
AS $$
BEGIN
RETURN QUERY
SELECT  ROUND(SUM(oi.unit_price*oi.quantity)::decimal,2)AS total_revenue,order_date AS date
FROM order_item AS oi LEFT JOIN "order" AS o ON o.order_id = oi.order_fk
WHERE o.order_date = report_date
GROUP BY o.order_date
ORDER BY total_revenue DESC;
END
$$ LANGUAGE plpgsql;

--function test
select * from total_revenue_by_date('2024-07-23');