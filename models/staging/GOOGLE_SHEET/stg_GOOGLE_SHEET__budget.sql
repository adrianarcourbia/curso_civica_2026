with 

source as (

    select * from {{ source('GOOGLE_SHEET', 'budget') }}

),

renamed as (

    select
        _row,
        quantity,
        month,
        product_id,
        _fivetran_synced

    from source

)

select * from renamed