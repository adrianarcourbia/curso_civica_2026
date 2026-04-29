with source as (
    select * from {{ source('POSTGRE_DB', 'USER') }}
),

renamed as (
    select
        -- Identificadores (Claves para el DAG de dbt)
        cast(user_id as varchar) as user_id,
        cast(address_id as varchar) as address_id,

        -- Información personal
        cast(first_name as varchar) as first_name,
        cast(last_name as varchar) as last_name,
        cast(email as varchar) as email,
        cast(phone_number as varchar) as phone_number,

        -- Métricas de usuario
        try_cast(total_orders as number) as total_orders,

        -- Fechas de registro y actividad (NTZ según Snowflake)
        cast(created_at as timestamp_ntz) as created_at_utc,
        cast(updated_at as timestamp_ntz) as updated_at_utc,

        -- Metadatos técnicos de Fivetran
        cast(_fivetran_deleted as boolean) as is_deleted,
        cast(_fivetran_synced as timestamp_ntz) as date_load

    from source
)

select * from renamed