{% macro count_items(col, event_type) %}
    sum(case when '{{col}}' = '{{ event_type }}' then 1 else 0 end)
{% endmacro %}