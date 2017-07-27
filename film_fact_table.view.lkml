view: film_fact_table {
  derived_table: {
    sql: SELECT a.*,@curRank := @curRank + 1 AS rank
    FROM(
      SELECT
        film.film_id  AS film_id,
        COALESCE(SUM(payment.amount ), 0) AS total_amount
      FROM sakila.payment  AS payment
      LEFT JOIN sakila.rental  AS rental ON payment.rental_id = rental.rental_id
      LEFT JOIN sakila.inventory  AS inventory ON rental.inventory_id = inventory.inventory_id
      LEFT JOIN sakila.film  AS film ON inventory.film_id = film.film_id

      WHERE
            1=1
            AND {% condition rental.rental_date %} rental.rental_date {% endcondition %}
            AND {% condition rental.rental_year %} rental.rental_date {% endcondition %}
            -- {% date_start rental.rental_date %} {% date_end rental.rental_date %}

      GROUP BY 1
      )a, (SELECT @curRank := 0) r

  ORDER BY a.total_amount DESC;;
  }

  measure: count {
    type: count
  }

  dimension: film_id {
    type: number
    sql: ${TABLE}.film_id ;;
  }

  dimension: total_amount {
    type: number
    sql: ${TABLE}.total_amount ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }


  dimension: ranked_title {
    type: string
    sql:
        CASE
          WHEN ${rank} < 10 THEN CONCAT('0',${rank},') ', ${film.title})
          ELSE CONCAT(${rank},') ', ${film.title})
        END
    ;;
  }


}
