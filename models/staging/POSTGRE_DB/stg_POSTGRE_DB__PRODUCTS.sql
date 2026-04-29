with source as (
    select * from {{ source('POSTGRE_DB', 'PRODUCTS') }}
),

renamed as (
    select
        -- Identificador único
        cast(product_id as varchar) as product_id,

        -- Dimensiones
        cast(name as varchar) as name,

        -- Métricas (Usamos TRY_CAST para asegurar que sean números operables)
        try_cast(price as number(38,2)) as price_usd,
        try_cast(inventory as number) as inventory_quantity,

        -- Metadatos de carga
        cast(_fivetran_deleted as boolean) as is_deleted,
        cast(_fivetran_synced as timestamp_ntz) as date_load

    from source
)

select * from renamed