with 

source as (

    select * from {{ source('POSTGRE_DB', 'PROMOS') }}

),

renamed as (

    select
        promo_id,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed