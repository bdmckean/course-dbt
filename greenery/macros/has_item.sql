{% macro has_item(col, item_name) %}
    MAX(CASE WHEN {{ col }} = '{{ item_name }}' THEN TRUE ELSE FALSE END) as has_{{ item_name | replace(' ', '_') }}
{% endmacro %}