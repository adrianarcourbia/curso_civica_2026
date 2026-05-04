{% snapshot users_timestamp_snp %}

{{
    config(
        target_schema='snapshots',
        unique_key='DNI',
        strategy='timestamp',
        hard_deletes= 'new_record',
        updated_at='fecha_alta_sistema'
    )
}}

SELECT
    Nombre,
    DNI,
    email,
    fecha_alta_sistema
FROM {{ source('GOOGLE_SHEETS', 'users') }}

{% endsnapshot %}