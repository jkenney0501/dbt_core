-- macro checks for null values in all the columnd by looping over the columns checking or nulls
-- hyphen is to trim whitespaces
-- create model in tests after this

{% macro no_nulls_in_columns(model) %}

    SELECT * 
    FROM 
        {{ model }} 
    WHERE
        {% for col in adapter.get_columns_in_relation(model) -%}

        {{ col.column }} IS NULL OR

    {% endfor %}

    FALSE

{% endmacro %}