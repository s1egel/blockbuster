view: store {
  sql_table_name: sakila.store ;;

  dimension: store_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.store_id ;;
  }

  dimension: address_id {
    type: number
    hidden: yes
    sql: ${TABLE}.address_id ;;
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

  dimension: manager_staff_id {
    type: number
    hidden: yes
    sql: ${TABLE}.manager_staff_id ;;
  }
}
