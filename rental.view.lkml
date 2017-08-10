view: rental {
  sql_table_name: sakila.rental ;;

  dimension: rental_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.rental_id ;;
  }

  dimension: customer_id {
    type: number
    hidden: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: inventory_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_id ;;
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

  dimension_group: rental {
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
    sql: ${TABLE}.rental_date ;;
  }

  dimension_group: return {
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
    sql: ${TABLE}.return_date ;;
  }

  dimension: staff_id {
    type: number
    hidden: yes
    sql: ${TABLE}.staff_id ;;
  }

  dimension: days_overdue {
    type: number
    sql: TIMESTAMPDIFF(DAY, ${rental_date},${return_date});;
  }

  dimension: rental_status {
    type: string
    sql: CASE
           WHEN ${days_overdue} > 14 THEN "Overdue"
           WHEN ${return_date} IS NULL THEN "Not Returned"
           ELSE "Returned"
         END;;
  }

  measure: total_rentals_overdue {
    type: count
    filters: {
      field: rental_status
      value: "Overdue"
    }
    drill_fields: [
      customer.full_name
      , customer.email
      , film.title
      , rental_date
      , return_date
      , days_overdue]
  }

  measure: total_days_overdue {
    type: sum
    sql: ${days_overdue} ;;
  }

  measure: average_days_overdue {
    type: average
    sql: ${days_overdue} ;;
  }

  measure: total_rentals_not_returned {
    type: count
    filters: {
      field: rental_status
      value: "Not Returned"
    }
    drill_fields: [
      customer.full_name
    , customer.email
    , film.title
    , rental_date
    , return_date
    , days_overdue]
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      customer.full_name
    , customer.email
    , film.title
    , rental_date
    , return_date
    , payment.amount
    ]
  }
}
