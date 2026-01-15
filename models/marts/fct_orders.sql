{{
    config(
        materialized='table'
    )
}}

with orders as (
    select * from {{ ref('stg_tpch_orders') }}
),

line_items as (
    select * from {{ ref('stg_tpch_lineitem') }}
)

select 
    orders.order_id,
    orders.customer_id,
    orders.order_date,
    count(line_items.lineitem_id) as number_of_items,
    sum(line_items.extended_price) as gross_item_sales_amount
from orders
join line_items on orders.order_id = line_items.order_id
group by 1, 2, 3