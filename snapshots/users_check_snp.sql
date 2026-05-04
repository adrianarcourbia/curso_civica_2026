{% snapshot users_check_snp %}

{{
    config(
        target_schema='snapshots',
        unique_key='DNI',
        strategy='check',
        hard_deletes= 'new_record',
        check_cols=['Nombre', 'email']
    )
}}

SELECT
    Nombre,
    DNI,
    email,
    fecha_alta_sistema
FROM {{ source('GOOGLE_SHEETS', 'users') }}

{% endsnapshot %}