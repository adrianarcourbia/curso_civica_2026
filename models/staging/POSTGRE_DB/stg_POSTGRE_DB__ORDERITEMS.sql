with 

source as (

    select * from {{ source('POSTGRE_DB', 'ORDERITEMS') }}

),

renamed as (

select
        -- IDs: Los mantenemos como varchar para asegurar la integridad de la cadena
        cast(order_id as varchar) as order_id,
        cast(product_id as varchar) as product_id,

        -- QUANTITY: Usamos cast simple porque si no hay un número, 
        -- queremos que dbt nos avise (un pedido sin cantidad es un error grave)
        cast(quantity as number) as quantity,

        -- Limpieza de metadatos de Fivetran
        cast(_fivetran_deleted as boolean) as is_deleted,
        cast(_fivetran_synced as timestamp_ntz) as date_load

    from source

)

select * from renamed