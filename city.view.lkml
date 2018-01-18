view: city {
  sql_table_name: sakila.city ;;

  dimension: city_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.city_id ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country_id {
    type: number
    hidden: yes
    sql: ${TABLE}.country_id ;;
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
