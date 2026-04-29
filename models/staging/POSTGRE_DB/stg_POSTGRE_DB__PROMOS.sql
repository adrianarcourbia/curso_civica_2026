with source as (
    select * from {{ source('POSTGRE_DB', 'PROMOS') }}
),

renamed as (
    select
        -- Identificador (Nombre de la promo: 'task-force', 'leverage'...)
        cast(promo_id as varchar) as promo_id,

        -- Métricas: El descuento aplicado (2, 13, 10...)
        try_cast(discount as number) as discount_usd,

        -- Estado de la promoción
        cast(status as varchar) as status,

        -- Metadatos técnicos
        cast(_fivetran_deleted as boolean) as is_deleted,
        cast(_fivetran_synced as timestamp_ntz) as date_load

    from source
)

select * from renamed