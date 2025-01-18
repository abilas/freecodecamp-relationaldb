#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\n\n~~~Number Guessing Game~~~\n"

MAIN_MENU() {
  # check for an argument being passed...meaning an error
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "Enter your username:"
  read USERNAME

  # search for current user in database
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';")

  if [[ -z $USER_ID ]]
  then
   # insert new user
   INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME');")
   # get user id
   USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME';")
   echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
  else
    # get existing user data
    GET_USER_GAMES_DATA=$($PSQL "SELECT COUNT(*), MIN(total_guesses) FROM games WHERE user_id = $USER_ID;")
    echo $GET_USER_GAMES_DATA | while IFS="|" read -a Read
    do
      echo -e "\nWelcome back, $USERNAME! You have played ${Read[0]} games, and your best game took ${Read[1]} guesses.\n"
    done
  fi

  # start game
  # generate a random number
  SECRET_NUMBER=$(( $RANDOM % 1001 ))
  
  # get user guess
  echo -e "\nGuess the secret number between 1 and 1000:"
  read USER_GUESS

  # initiate guess count
  NUMBER_OF_GUESSES=1
  while [[ $USER_GUESS != $SECRET_NUMBER ]]
  do
    if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
    then
      echo "That is not an integer, guess again:"
      read USER_GUESS 
    else
      if [[ $USER_GUESS > $SECRET_NUMBER ]]
      then
        NUMBER_OF_GUESSES=$(( $NUMBER_OF_GUESSES + 1 ))
        echo "It's lower than that, guess again:"
        read USER_GUESS
      else
        NUMBER_OF_GUESSES=$(( $NUMBER_OF_GUESSES + 1 ))
        echo "It's higher than that, guess again:"
        read USER_GUESS
      fi
    fi
  done
  
  # add new game to results table
  INSERT_NEW_GAME=$($PSQL "INSERT INTO games(user_id, total_guesses, result_value) VALUES($USER_ID, $NUMBER_OF_GUESSES, $SECRET_NUMBER);")
  echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!\n"

}

MAIN_MENU