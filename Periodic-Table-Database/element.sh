# POSTGRESQL connection string variable
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z  $1 ]]
then
  echo "Please provide an element as an argument."
else
  SELECTED_ELEMENT=$1
  
  # Element input as atomic number
  if [[ $SELECTED_ELEMENT =~ ^[0-9]+$ ]]
  then
    OUTPUT=$($PSQL "SELECT elements.atomic_number, elements.symbol, elements.name, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, types.type from elements join properties on elements.atomic_number = properties.atomic_number join types on properties.type_id = types.type_id where elements.atomic_number = $SELECTED_ELEMENT")
    # check if an element is returned
    if [[ ! -z $OUTPUT ]]
    then
      echo "$OUTPUT" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    else
      echo "I could not find that element in the database."
    fi

  # check if the argument is a name
  elif [[ $SELECTED_ELEMENT =~ ^[^0-9]{3,}$ ]]
  then 
    OUTPUT=$($PSQL "SELECT elements.atomic_number, elements.symbol, elements.name, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, types.type from elements join properties on elements.atomic_number = properties.atomic_number join types on properties.type_id = types.type_id where elements.name = '$SELECTED_ELEMENT'")
    # check if an element is returned
    if [[ ! -z $OUTPUT ]]
    then
      echo "$OUTPUT" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    else
      echo "I could not find that element in the database."
    fi
  # Element input as symbol
  elif [[ $SELECTED_ELEMENT =~ ^[^0-9]{1,2}$ ]]
  then 
    OUTPUT=$($PSQL "SELECT elements.atomic_number, elements.symbol, elements.name, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius, types.type from elements join properties on elements.atomic_number = properties.atomic_number join types on properties.type_id = types.type_id where elements.symbol = '$SELECTED_ELEMENT'")
    # check if an element is returned
    if [[ ! -z $OUTPUT ]]
    then
      echo "$OUTPUT" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    else
      echo "I could not find that element in the database."
    fi
  
  else
    echo "I could not find that element in the database."
    
  fi
fi