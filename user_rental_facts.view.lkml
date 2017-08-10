view: user_rental_facts {
  derived_table: {
    sql: SELECT
        rental.customer_id
        , COUNT(DISTINCT rental.rental_id) AS lifetime_rentals
        , SUM(payment.amount) AS lifetime_revenue
        , MIN(NULLIF(rental.rental_date,0)) AS first_rental
        , MAX(NULLIF(rental.rental_date,0)) AS latest_rental
        , COUNT(DISTINCT DATE_FORMAT(rental.rental_date, '%Y-%m-01')) AS number_of_distinct_months_with_rentals
      FROM sakila.rental
      LEFT JOIN sakila.payment ON
                                 (rental.rental_id = payment.rental_id)
      GROUP BY customer_id
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: customer_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.customer_id ;;
  }

  dimension: lifetime_rentals {
    type: number
    sql: ${TABLE}.lifetime_rentals ;;
  }

  dimension: lifetime_revenue {
    type: number
    sql: ${TABLE}.lifetime_revenue ;;
  }

  dimension: first_rental {
    type: string
    sql: ${TABLE}.first_rental ;;
  }

  dimension: latest_rental {
    type: string
    sql: ${TABLE}.latest_rental ;;
  }

  dimension: months_since_last_rental {
    type: number
    sql: TIMESTAMPDIFF(MONTH,${latest_rental},'2006-02-14 15:16:03') ;;
  }

  dimension: number_of_distinct_months_with_rentals {
    type: number
    sql: ${TABLE}.number_of_distinct_months_with_rentals ;;
  }


  set: detail {
    fields: [
      customer_id,
      customer.full_name,
      customer.email,
      lifetime_rentals,
      lifetime_revenue,
      first_rental,
      latest_rental,
      number_of_distinct_months_with_rentals
    ]
  }
}
