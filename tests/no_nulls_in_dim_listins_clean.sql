-- runs the macro "no_nulls_in_columns"
-- use jinja macro to reference

{{
    no_nulls_in_columns( ref('int_dim_listings_clean') )
}}