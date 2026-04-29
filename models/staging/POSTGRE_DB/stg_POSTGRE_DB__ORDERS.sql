with source as (
    select * from {{ source('POSTGRE_DB', 'ORDERS') }}
),

renamed as (
    select
        -- Identificadores (Críticos: usamos CAST)
        cast(order_id as varchar) as order_id,
        cast(user_id as varchar) as user_id,
        cast(address_id as varchar) as address_id,
        cast(promo_id as varchar) as promo_id,
        cast(tracking_id as varchar) as tracking_id,

        -- Dimensiones de texto
        cast(shipping_service as varchar) as shipping_service,
        cast(status as varchar) as status,

        -- Importes (Flexibles: usamos TRY_CAST por si viene basura)
        try_cast(shipping_cost as number(38,2)) as shipping_cost_usd,
        try_cast(order_cost as number(38,2)) as order_cost_usd,
        try_cast(order_total as number(38,2)) as order_total_usd,

        -- Fechas (NTZ según el error previo)
        cast(created_at as timestamp_ntz) as created_at_utc,
        cast(estimated_delivery_at as timestamp_ntz) as estimated_delivery_at_utc,
        cast(delivered_at as timestamp_ntz) as delivered_at_utc,

        -- Metadatos
        cast(_fivetran_deleted as boolean) as is_deleted,
        cast(_fivetran_synced as timestamp_ntz) as date_load

    from source
)

select * from renamed