with source as (

    select * from {{ source('tpch', 'lineitem') }}

),

renamed as (
-- Hello World
    select
        -- ID columns
        {{ dbt_utils.generate_surrogate_key(['l_orderkey', 'l_linenumber']) }} as lineitem_id, -- Unique Key generation
        l_orderkey as order_id,
        l_partkey as part_id,
        l_suppkey as supplier_id,

        -- Order details
        l_linenumber as line_number,
        l_quantity as quantity,
        l_extendedprice as extended_price,
        l_discount as discount_percentage,
        l_tax as tax_rate,

        -- Status and Dates
        l_returnflag as return_flag,
        l_linestatus as line_status,
        l_shipdate as ship_date,
        l_commitdate as commit_date,
        l_receiptdate as receipt_date,
        
        -- Shipping info
        l_shipinstruct as ship_instructions,
        l_shipmode as ship_mode

    from source

)

select * from renamed