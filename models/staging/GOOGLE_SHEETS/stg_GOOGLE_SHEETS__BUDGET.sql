with source as (

    select * from {{ source('GOOGLE_SHEETS', 'budget') }}

),

renamed as (

    select
        -- Cambiamos _ROW por ROW_ID (tipo integer/fixed)
        cast(_row as integer) as row_id,

        -- PRODUCT_ID se queda igual
        cast(product_id as varchar) as product_id,

        -- QUANTITY a integer
        try_cast(quantity as integer) as quantity,

        -- Cambiamos MONTH por BUDGET_MONTH
        cast(month as date) as budget_month,

        -- Cambiamos _FIVETRAN_SYNCED por DATE_LOAD
        cast(_fivetran_synced as timestamp_ntz) as date_load

    from source

)

select * from renamed