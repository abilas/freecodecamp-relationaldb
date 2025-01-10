#! /bin/bash

# Variables to use: SERVICE_ID_SELECTED, CUSTOMER_PHONE, CUSTOMER_NAME, SERVICE_TIME

# POSTGRESQL connection string variable
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo "Welcome to My Salon, how can I help you?"
  fi

  # get available services
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")

  # if no services available, return to main menu
  if [[ -z $AVAILABLE_SERVICES ]]
  then
    # go to main menu
    "Sorry, there are no services available at the moment."
  else  
    # display services
    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID NAME
    do
      echo "$SERVICE_ID) $NAME" | sed 's/ |//'
    done

    # get selected service
    read SERVICE_ID_SELECTED

    # if input is not a number
    if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
    then
      #send to main menu
      MAIN_MENU "I could not find that service. What would you like today?"
    else
      # get service name
      SERVICE_TYPE=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

      # if not available
      if [[ -z $SERVICE_TYPE ]]
      then
        # send to main menu
        MAIN_MENU "I could not find that service. What would you like today?"
      else
        # get customer phone number
        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE

        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        # if customer doesn't exist
        if [[ -z $CUSTOMER_NAME ]]
        then  
          # get new customer name
          echo -e "\nWhat's your name?"
          read CUSTOMER_NAME

          # insert new customer
          INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
        fi

        # get service time
        echo -e "\nWhat time would you like your $(echo $SERVICE_TYPE | sed -E 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')?"
        read SERVICE_TIME

        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

        INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments (time, customer_id, service_id) VALUES ('$SERVICE_TIME', $CUSTOMER_ID, $SERVICE_ID_SELECTED)")

        echo -e "\nI have put you down for a $(echo $SERVICE_TYPE | sed -E 's/^ *| *$//g') at $(echo $SERVICE_TIME | sed -E 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
      
      fi

    fi
    
  fi

}

# APPOINTMENT_MENU() {

# }

MAIN_MENU