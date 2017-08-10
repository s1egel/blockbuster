view: address {
  sql_table_name: sakila.address ;;
  view_label: "Store Address"

  dimension: address_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.address_id ;;
  }

  dimension: address {
    type: string
    link: {
      label: "Store Management Dashboard"
      url: "/dashboards/58?Store%20Filter={{ value }}"
      icon_url: "http://looker.com/favicon.ico"
    }
    sql: ${TABLE}.address ;;
  }

  dimension: address2 {
    type: string
    sql: ${TABLE}.address2 ;;
  }

  dimension: city_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.city_id ;;
  }

  dimension: district {
    type: string
    sql: ${TABLE}.district ;;
  }

  dimension_group: last_update {
    hidden: yes
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

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: postal_code {
    type: zipcode
    sql: ${TABLE}.postal_code ;;
  }

  measure: count {
    type: count
    drill_fields: [address_id, city.city_id, customer.count, staff.count, store.count]
  }
}
