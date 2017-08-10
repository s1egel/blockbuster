view: category {
  sql_table_name: sakila.category ;;
  view_label: "Film Category"

  dimension: category_id {
    primary_key: yes
    hidden: yes
    type: yesno
    sql: ${TABLE}.category_id ;;
  }

  dimension_group: last_update {
    type: time
    hidden: yes
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.last_update ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    type: count
    drill_fields: [category_id, name, film_category.count]
  }
}
