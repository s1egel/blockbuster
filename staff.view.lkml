view: staff {
  sql_table_name: sakila.staff ;;

  dimension: staff_id {
    primary_key: yes
    hidden: yes
    type: yesno
    sql: ${TABLE}.staff_id ;;
  }

  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
  }

  dimension: address_id {
    type: number
    hidden: yes
    sql: ${TABLE}.address_id ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    hidden: yes
    sql: ${TABLE}.first_name ;;
  }

  dimension: last_name {
    type: string
    hidden: yes
    sql: ${TABLE}.last_name ;;
  }

  dimension: full_name {
    type: string
    sql: CONCAT(${first_name}," ",${last_name}) ;;
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

  dimension: password {
    type: string
    sql: ${TABLE}.password ;;
  }

  dimension: picture {
    type: string
    sql: ${TABLE}.picture ;;
  }

  dimension: store_id {
    type: yesno
    hidden: yes
    sql: ${TABLE}.store_id ;;
  }

  dimension: username {
    type: string
    sql: ${TABLE}.username ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      staff_id,
      first_name,
      last_name,
      username,
      address.address_id,
      store.store_id,
      payment.count,
      rental.count
    ]
  }
}
