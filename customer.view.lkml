view: customer {
  sql_table_name: sakila.customer ;;

  dimension: customer_id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.customer_id ;;
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

  dimension_group: create {
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
    sql: ${TABLE}.create_date ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;

    action: {
      label: "Send Promotional Email"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Hey there {{ customer.full_name._value }}"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Dear {{ customer.full_name._value }},

        Looks like you haven't made a rental in a while!  We'd like to offer you a 10% discount
        on your next rental!  Just use the code RENTME when checking out!

        Your friends at B. Blockbuster"
      }
    }
    required_fields: [full_name, first_name]

    action: {
      label: "Send Overdue Rental Email"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Hey there {{ customer.full_name._value }}"
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Dear {{ customer.full_name._value }},

        We are writing to let you know that you have an overdue video rental.
        In order to prevent any overdue charges, please return your video rental as soon as possible.

        Your friends at B. Blockbuster"
      }
    }
    required_fields: [full_name, first_name]
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

  dimension: store_id {
    type: yesno
    hidden: yes
    sql: ${TABLE}.store_id ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      customer_id,
      first_name,
      last_name,
      store.store_id,
      address.address_id,
      payment.count,
      rental.count
    ]
  }
}
