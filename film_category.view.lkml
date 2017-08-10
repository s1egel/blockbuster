view: film_category {
  sql_table_name: sakila.film_category ;;

  dimension: category_id {
    type: number
    hidden: yes
    sql: ${TABLE}.category_id ;;
  }

  dimension: film_id {
    type: number
    hidden: yes
    sql: ${TABLE}.film_id ;;
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
}
