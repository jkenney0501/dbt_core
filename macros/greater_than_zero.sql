-- custome test
-- test for greater tahn zero values in a column
-- can be called as a generic test in your schema.yml

{% test positive_value(model, column_name) %}

    select *
    from
        {{ model }}
    where {{ column_name }} < 1

{% endtest %}