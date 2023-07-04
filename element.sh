#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
ELEMENT_NOT_FOUND_MESSAGE="I could not find that element in the database.";

PROGRAM() {
  # If no argument passed, show message saying please provide argument
  if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument.";
  fi
  # If argument exists. check if argument is number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ARG=$1;
    ELEMENT_ATOMIC_NO="$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$ARG")";
    # If element with atomic number exists
    if [[ -z $ELEMENT_ATOMIC_NO ]]
    then
      # If eleemnt not found; return relevant message
      echo $ELEMENT_NOT_FOUND_MESSAGE;
    else
      # Eles; fetch element info
      ELEMENT_TYPE_ID="$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NO")";

      ELEMENT_INFO="$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, type, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties ON elements.atomic_number=properties.atomic_number LEFT JOIN types ON properties.type_id=types.type_id WHERE elements.atomic_number=$ELEMENT_ATOMIC_NO AND properties.type_id=$ELEMENT_TYPE_ID")";

      IFS=$'|' read -r ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS TYPE MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS <<< "$ELEMENT_INFO";
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius.";
    fi
  # Check if argument is symbol or name
  elif [[ $1 =~ ^[a-zA-Z]+$ ]]
  then
    ARG=$1;
    ELEMENT=${ARG^};
    # If element with name or symbol exists
    if [[ ${#ELEMENT} -le 2 ]]
    then
      ELEMENT_ATOMIC_NO="$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ELEMENT'")"
      if [[ -z $ELEMENT_ATOMIC_NO ]]
      then
        echo $ELEMENT_NOT_FOUND_MESSAGE
      else
        ELEMENT_TYPE_ID="$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NO")";

        ELEMENT_INFO="$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, type, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties ON elements.atomic_number=properties.atomic_number LEFT JOIN types ON properties.type_id=types.type_id WHERE elements.atomic_number=$ELEMENT_ATOMIC_NO AND properties.type_id=$ELEMENT_TYPE_ID")";

        IFS=$'|' read -r ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS TYPE MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS <<< "$ELEMENT_INFO";
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius.";
      fi
    elif [[ ${#ELEMENT} -gt 2 ]]
    then
      ELEMENT_ATOMIC_NO="$($PSQL "SELECT atomic_number FROM elements WHERE name='$ELEMENT'")"
      if [[ -z $ELEMENT_ATOMIC_NO ]]
      then
        echo $ELEMENT_NOT_FOUND_MESSAGE
      else
        ELEMENT_TYPE_ID="$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ELEMENT_ATOMIC_NO")";

        ELEMENT_INFO="$($PSQL "SELECT elements.atomic_number, symbol, name, atomic_mass, type, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties ON elements.atomic_number=properties.atomic_number LEFT JOIN types ON properties.type_id=types.type_id WHERE elements.atomic_number=$ELEMENT_ATOMIC_NO AND properties.type_id=$ELEMENT_TYPE_ID")";

        IFS=$'|' read -r ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS TYPE MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS <<< "$ELEMENT_INFO";
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius.";
      fi  
    fi
  fi
}

PROGRAM $1