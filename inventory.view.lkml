view: inventory {
  sql_table_name: sakila.inventory ;;

  dimension: inventory_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.inventory_id ;;
  }

  dimension: film_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.film_id ;;
  }

  dimension_group: last_update {
    type: time
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

  dimension: days_in_inventory {
    description: "days between created and sold date"
    type: number
    sql: TIMESTAMPDIFF(DAY, ${last_update_date}, '2006-12-31' ) ;;
  }

  dimension: days_in_inventory_tier {
    type: tier
    sql: ${days_in_inventory} ;;
    style: integer
    tiers: [0, 5, 10, 20, 40, 80, 160, 360, 720]
  }

  dimension: store_id {
    type: yesno
    # hidden: yes
    sql: ${TABLE}.store_id ;;
  }

  measure: count {
    type: count
    drill_fields: [inventory_id, film.title, days_in_inventory, days_in_inventory_tier]
  }
}
