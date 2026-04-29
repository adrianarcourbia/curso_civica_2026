with source as (

    select * from {{ source('POSTGRE_DB', 'ADDRESSES') }}

),

renamed as (

    select
        -- ID: Es un UUID, lo aseguramos como varchar
        cast(address_id as varchar) as address_id,

        -- ZIPCODE: Pasamos a VARCHAR para no perder ceros a la izquierda
        cast(zipcode as varchar) as zipcode,

        cast(country as varchar) as country,
        cast(address as varchar) as address,
        cast(state as varchar) as state,

        -- BOOLEAN: Mapeo de borrados lógicos
        cast(_fivetran_deleted as boolean) as is_deleted,

        -- TIMESTAMP: Tipo NTZ según el esquema de Snowflake
        cast(_fivetran_synced as timestamp_ntz) as date_load

    from source

)

select * from renamed